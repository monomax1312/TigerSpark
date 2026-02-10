import '../../domain/entities/check_in.dart';
import '../../domain/entities/insight.dart';
import '../../domain/repositories/check_in_repository.dart';
import '../../domain/repositories/insight_repository.dart';

class InsightRepositoryImpl implements InsightRepository {
  InsightRepositoryImpl(this._checkInRepository);

  final CheckInRepository _checkInRepository;

  @override
  Future<List<Insight>> getInsights() async {
    final checkIns = await _checkInRepository.getCheckIns();
    return _computeInsights(checkIns);
  }

  @override
  Future<void> refreshInsights() async {
  }

  List<Insight> _computeInsights(List<CheckIn> checkIns) {
    final now = DateTime.now();
    final insights = <Insight>[];
    var i = 0;

    if (checkIns.length >= 5) {
      final byHour = <int, List<CheckIn>>{};
      for (final c in checkIns) {
        if (c.at.isAfter(now.subtract(const Duration(days: 14)))) {
          byHour.putIfAbsent(c.at.hour, () => []).add(c);
        }
      }
      if (byHour.isNotEmpty) {
        int bestHour = 10;
        double bestAvg = 0;
        for (final e in byHour.entries) {
          final avg = e.value.map((x) => x.energy.value.toDouble()).reduce((a, b) => a + b) /
              e.value.length;
          if (avg > bestAvg) {
            bestAvg = avg;
            bestHour = e.key;
          }
        }
        final endHourClamped = (bestHour + 2) > 23 ? 23 : (bestHour + 2);
        insights.add(Insight(
          id: 'ins_${i++}',
          type: InsightType.energyPeakTime,
          title: '',
          body: '',
          iconName: 'bolt',
          priority: 1,
          generatedAt: now,
          formatParams: {'start': '$bestHour', 'end': '$endHourClamped'},
        ));
      }

      final tenseCount = checkIns.where((c) => c.mood == MoodState.tense).length;
      if (tenseCount > checkIns.length ~/ 2) {
        insights.add(Insight(
          id: 'ins_${i++}',
          type: InsightType.custom,
          title: 'Напряжение',
          body: 'Часто отмечаешь напряжённость. Попробуй короткие паузы или дыхательные упражнения.',
          iconName: 'psychology',
          priority: 2,
          generatedAt: now,
        ));
      }

      insights.add(Insight(
        id: 'ins_${i++}',
        type: InsightType.bestTimeForHardTasks,
        title: 'Сложные задачи',
        body: 'Лучшее время для сложных задач — утро, когда энергия и фокус выше.',
        iconName: 'schedule',
        priority: 3,
        generatedAt: now,
      ));
    } else {
      insights.add(Insight(
        id: 'ins_0',
        type: InsightType.custom,
        title: 'Нужно больше данных',
        body: 'Отмечай состояние несколько раз в день — через 3–5 дней появятся персональные инсайты.',
        iconName: 'insights',
        priority: 0,
        generatedAt: now,
      ));
    }

    return insights;
  }
}
