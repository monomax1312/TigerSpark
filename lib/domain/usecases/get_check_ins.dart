import '../entities/check_in.dart';
import '../repositories/check_in_repository.dart';

class GetCheckIns {
  const GetCheckIns(this._repository);
  final CheckInRepository _repository;

  Future<List<CheckIn>> call({DateTime? from, DateTime? to}) =>
      _repository.getCheckIns(from: from, to: to);
}
