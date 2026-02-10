import '../entities/check_in.dart';
import '../repositories/check_in_repository.dart';

class GetLatestCheckIn {
  const GetLatestCheckIn(this._repository);
  final CheckInRepository _repository;

  Future<CheckIn?> call() => _repository.getLatestCheckIn();
}
