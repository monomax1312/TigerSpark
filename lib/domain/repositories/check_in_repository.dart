import '../entities/check_in.dart';
import '../entities/energy_summary.dart';

abstract class CheckInRepository {
  Future<List<CheckIn>> getCheckIns({DateTime? from, DateTime? to});
  Future<CheckIn> addCheckIn(CheckInDraft draft);
  Future<CheckIn?> getLatestCheckIn();
  Future<List<EnergySummary>> getEnergySummaries(int days);
}
