import '../../domain/entities/check_in.dart';
import '../../domain/entities/energy_summary.dart';
import '../../domain/repositories/check_in_repository.dart';
import '../local/check_in_storage.dart';
import '../models/check_in_dto.dart';

class CheckInRepositoryImpl implements CheckInRepository {
  CheckInRepositoryImpl(this._storage);

  final CheckInStorage _storage;

  @override
  Future<List<CheckIn>> getCheckIns({DateTime? from, DateTime? to}) async {
    final list = await _storage.load();
    var entities = list.map((d) => d.toEntity()).toList();
    if (from != null) {
      entities = entities.where((e) => e.at.isAfter(from) || e.at.isAtSameMomentAs(from)).toList();
    }
    if (to != null) {
      entities = entities.where((e) => e.at.isBefore(to) || e.at.isAtSameMomentAs(to)).toList();
    }
    entities.sort((a, b) => b.at.compareTo(a.at));
    return entities;
  }

  @override
  Future<CheckIn> addCheckIn(CheckInDraft draft) async {
    final checkIn = CheckIn(
      id: _generateId(),
      energy: draft.energy,
      mood: draft.mood,
      focus: draft.focus,
      at: DateTime.now(),
    );
    final list = await _storage.load();
    list.add(CheckInDto.fromEntity(checkIn));
    await _storage.save(list);
    return checkIn;
  }

  static String _generateId() {
    return '${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  Future<CheckIn?> getLatestCheckIn() async {
    final list = await getCheckIns();
    return list.isEmpty ? null : list.first;
  }

  @override
  Future<List<EnergySummary>> getEnergySummaries(int days) async {
    final all = await getCheckIns();
    final now = DateTime.now();
    final from = now.subtract(Duration(days: days));
    final filtered = all.where((c) => c.at.isAfter(from) || c.at.isAtSameMomentAs(from)).toList();

    final byDay = <DateTime, List<CheckIn>>{};
    for (final c in filtered) {
      final day = DateTime(c.at.year, c.at.month, c.at.day);
      byDay.putIfAbsent(day, () => []).add(c);
    }

    final result = <EnergySummary>[];
    for (var d = 0; d < days; d++) {
      final date = DateTime(now.year, now.month, now.day).subtract(Duration(days: d));
      final dayCheckIns = byDay[date] ?? [];
      if (dayCheckIns.isEmpty) {
        result.add(EnergySummary(date: date, averageEnergy: 0, checkInCount: 0));
      } else {
        final avg = dayCheckIns.map((c) => c.energy.value.toDouble()).reduce((a, b) => a + b) /
            dayCheckIns.length;
        final byHour = <int, List<CheckIn>>{};
        for (final c in dayCheckIns) {
          byHour.putIfAbsent(c.at.hour, () => []).add(c);
        }
        int? peakHour;
        int? lowestHour;
        double peakAvg = 0;
        double lowAvg = 5;
        for (final entry in byHour.entries) {
          final hAvg = entry.value.map((c) => c.energy.value.toDouble()).reduce((a, b) => a + b) /
              entry.value.length;
          if (hAvg > peakAvg) {
            peakAvg = hAvg;
            peakHour = entry.key;
          }
          if (hAvg < lowAvg && hAvg > 0) {
            lowAvg = hAvg;
            lowestHour = entry.key;
          }
        }
        String? fluctuationLevel;
        if (dayCheckIns.length >= 2) {
          final values = dayCheckIns.map((c) => c.energy.value.toDouble()).toList();
          final range = values.reduce((a, b) => a > b ? a : b) - values.reduce((a, b) => a < b ? a : b);
          fluctuationLevel = range >= 2 ? 'high' : (range >= 1 ? 'medium' : 'low');
        }
        result.add(EnergySummary(
          date: date,
          averageEnergy: avg,
          checkInCount: dayCheckIns.length,
          peakHour: peakHour,
          lowestHour: lowestHour,
          fluctuationLevel: fluctuationLevel,
        ));
      }
    }
    result.sort((a, b) => a.date.compareTo(b.date));
    return result;
  }
}
