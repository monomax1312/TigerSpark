import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/logger/app_logger.dart';
import '../../../../domain/usecases/get_check_ins.dart';
import '../../../../domain/usecases/get_insights.dart';
import 'insights_event.dart';
import 'insights_state.dart';

class InsightsBloc extends Bloc<InsightsEvent, InsightsState> {
  InsightsBloc(this._getInsights, this._getCheckIns, this._logger)
      : super(const InsightsInitial()) {
    on<InsightsLoadRequested>(_onLoadRequested);
  }

  final GetInsights _getInsights;
  final GetCheckIns _getCheckIns;
  final AppLogger _logger;

  Future<void> _onLoadRequested(InsightsLoadRequested event, Emitter<InsightsState> emit) async {
    emit(const InsightsLoading());
    try {
      final insights = await _getInsights();
      final now = DateTime.now();
      final checkIns = await _getCheckIns(
        from: now.subtract(const Duration(days: 30)),
        to: now,
      );
      emit(InsightsLoaded(insights, totalCheckInCount: checkIns.length));
    } catch (e, st) {
      _logger.error(
        'InsightsLoadRequested failed',
        tag: 'InsightsBloc',
        error: e,
        stackTrace: st,
      );
      emit(InsightsError(e.toString()));
    }
  }
}
