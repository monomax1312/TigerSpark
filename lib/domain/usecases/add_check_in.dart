import '../entities/check_in.dart';
import '../repositories/check_in_repository.dart';

class AddCheckIn {
  const AddCheckIn(this._repository);
  final CheckInRepository _repository;

  Future<CheckIn> call(CheckInDraft draft) => _repository.addCheckIn(draft);
}
