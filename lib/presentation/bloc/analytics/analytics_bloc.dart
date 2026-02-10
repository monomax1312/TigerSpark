import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/logger/app_logger.dart';
import '../../../../domain/usecases/get_energy_summaries.dart';
import 'analytics_event.dart';
import 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  AnalyticsBloc(this._getEnergySummaries, this._logger) : super(const AnalyticsInitial()) {
    on<AnalyticsLoadRequested>(_onLoadRequested);
  }

  final GetEnergySummaries _getEnergySummaries;
  final AppLogger _logger;

  Future<void> _onLoadRequested(AnalyticsLoadRequested event, Emitter<AnalyticsState> emit) async {
    emit(const AnalyticsLoading());
    try {
      const days = 14;
      final summaries = await _getEnergySummaries(days);
      final totalCheckIns = summaries.fold<int>(0, (s, e) => s + e.checkInCount);
      String? summaryKey;
      if (totalCheckIns < 5) {
        summaryKey = 'fewData';
      } else {
        final withPeak = summaries.where((s) => s.peakHour != null && s.peakHour! >= 14).length;
        summaryKey = withPeak > summaries.length ~/ 2 ? 'rise' : 'fluctuations';
      }
      emit(AnalyticsLoaded(summaries, summaryKey: summaryKey));
    } catch (e, st) {
      _logger.error(
        'AnalyticsLoadRequested failed',
        tag: 'AnalyticsBloc',
        error: e,
        stackTrace: st,
      );
      emit(AnalyticsError(e.toString()));
    }
  }
}
