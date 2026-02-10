import '../../domain/entities/recommendation.dart';
import '../../domain/repositories/check_in_repository.dart';
import '../../domain/repositories/recommendation_repository.dart';

class RecommendationRepositoryImpl implements RecommendationRepository {
  RecommendationRepositoryImpl(this._checkInRepository);

  final CheckInRepository _checkInRepository;

  @override
  Future<List<Recommendation>> getRecommendations() async {
    final latest = await _checkInRepository.getLatestCheckIn();
    final summaries = await _checkInRepository.getEnergySummaries(7);
    final now = DateTime.now();
    final hour = now.hour;
    final recommendations = <Recommendation>[];

    if (summaries.isNotEmpty) {
      final withData = summaries.where((s) => s.checkInCount > 0).toList();
      if (withData.isNotEmpty) {
        final avgPeak = withData
            .map((s) => s.peakHour ?? 10)
            .reduce((a, b) => a + b) ~/ withData.length;
        final avgLow = withData
            .map((s) => s.lowestHour ?? 15)
            .reduce((a, b) => a + b) ~/ withData.length;

        if (hour >= avgPeak - 1 && hour <= avgPeak + 2) {
          recommendations.add(Recommendation(
            id: 'rec_work',
            kind: RecommendationKind.workBest,
            title: '',
            message: '',
            fromTime: DateTime(now.year, now.month, now.day, avgPeak),
            toTime: DateTime(now.year, now.month, now.day, avgPeak + 2),
          ));
        }
        if (hour >= avgLow - 1 && hour <= avgLow + 1) {
          recommendations.add(Recommendation(
            id: 'rec_pause',
            kind: RecommendationKind.takePause,
            title: '',
            message: '',
            fromTime: DateTime(now.year, now.month, now.day, avgLow),
            toTime: DateTime(now.year, now.month, now.day, avgLow + 1),
          ));
        }
        final inPeak = hour >= avgPeak - 1 && hour <= avgPeak + 2;
        final inLow = hour >= avgLow - 1 && hour <= avgLow + 1;
        if (!inPeak && !inLow && latest != null && latest.energy.value >= 2 && latest.energy.value <= 4) {
          recommendations.add(Recommendation(
            id: 'rec_light',
            kind: RecommendationKind.lightTasks,
            title: '',
            message: '',
          ));
        }
      }
    }

    if (latest != null && latest.energy.value <= 2) {
      recommendations.add(Recommendation(
        id: 'rec_decisions',
        kind: RecommendationKind.avoidDecisions,
        title: '',
        message: '',
      ));
    }

    if (recommendations.isEmpty) {
      recommendations.add(Recommendation(
        id: 'rec_default',
        kind: RecommendationKind.workBest,
        title: '',
        message: '',
      ));
    }

    return recommendations;
  }
}
