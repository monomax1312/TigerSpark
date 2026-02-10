import '../entities/energy_summary.dart';
import '../repositories/check_in_repository.dart';

class GetEnergySummaries {
  const GetEnergySummaries(this._repository);
  final CheckInRepository _repository;

  Future<List<EnergySummary>> call(int days) => _repository.getEnergySummaries(days);
}
