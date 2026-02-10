import 'package:equatable/equatable.dart';

import '../../../../domain/entities/check_in.dart';

abstract class CheckInEvent extends Equatable {
  const CheckInEvent();
  @override
  List<Object?> get props => [];
}

class CheckInSubmitted extends CheckInEvent {
  const CheckInSubmitted(this.draft);
  final CheckInDraft draft;
  @override
  List<Object?> get props => [draft];
}

class CheckInScreenOpened extends CheckInEvent {
  const CheckInScreenOpened();
}
