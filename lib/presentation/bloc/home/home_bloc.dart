import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/logger/app_logger.dart';
import '../../../../domain/usecases/get_check_ins.dart';
import '../../../../domain/usecases/get_energy_summaries.dart';
import '../../../../domain/usecases/get_latest_check_in.dart';
import '../../../../domain/usecases/get_recommendations.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    this._getLatestCheckIn,
    this._getRecommendations,
    this._getCheckIns,
    this._getEnergySummaries,
    this._logger,
  ) : super(const HomeInitial()) {
    on<HomeLoadRequested>(_onLoadRequested);
  }

  final GetLatestCheckIn _getLatestCheckIn;
  final GetRecommendations _getRecommendations;
  final GetCheckIns _getCheckIns;
  final GetEnergySummaries _getEnergySummaries;
  final AppLogger _logger;

  Future<void> _onLoadRequested(HomeLoadRequested event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());
    try {
      final latest = await _getLatestCheckIn();
      final recommendations = await _getRecommendations();
      final checkIns = await _getCheckIns();
      await _getEnergySummaries(14);
      final now = DateTime.now();
      final hour = now.hour;
      String? contextTitleKey;
      String? contextSubtitleKey;
      String? contextSubtitleParam;
      final atHour = checkIns.where((c) => c.at.isAfter(now.subtract(const Duration(days: 14))) && c.at.hour == hour).toList();
      if (atHour.length >= 2) {
        final avg = atHour.map((c) => c.energy.value).reduce((a, b) => a + b) / atHour.length;
        contextTitleKey = avg <= 2.5 ? 'homeContextPattern' : 'homeContextToday';
        contextSubtitleKey = avg <= 2.5 ? 'homeContextPatternDip' : 'homeContextUsualEnergy';
        if (avg <= 2.5) {
          contextSubtitleParam = null;
        } else {
          if (avg >= 4) {
            contextSubtitleParam = 'high';
          } else if (avg >= 3) {
            contextSubtitleParam = 'medium';
          } else {
            contextSubtitleParam = 'low';
          }
        }
      }
      String? microKey;
      if (checkIns.length >= 5) {
        if (hour >= 18) {
          microKey = 'homeMicroEveningFocus';
        } else if (hour >= 10 && hour <= 12) {
          microKey = 'homeMicroMorningPeak';
        } else {
          microKey = 'homeMicroNotice';
        }
      }
      emit(HomeLoaded(
        latestCheckIn: latest,
        recommendations: recommendations,
        contextDayTitleKey: contextTitleKey,
        contextDaySubtitleKey: contextSubtitleKey,
        contextDaySubtitleParam: contextSubtitleParam,
        microInsightKey: microKey,
      ));
    } catch (e, st) {
      _logger.error(
        'HomeLoadRequested failed',
        tag: 'HomeBloc',
        error: e,
        stackTrace: st,
      );
      emit(HomeError(e.toString()));
    }
  }
}
