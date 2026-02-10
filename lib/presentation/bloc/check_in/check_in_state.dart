import 'package:equatable/equatable.dart';

import '../../../../domain/entities/check_in.dart';

abstract class CheckInState extends Equatable {
  const CheckInState();
  @override
  List<Object?> get props => [];
}

class CheckInIdle extends CheckInState {
  const CheckInIdle();
}

class CheckInSubmitting extends CheckInState {
  const CheckInSubmitting();
}

class CheckInSuccess extends CheckInState {
  const CheckInSuccess(this.checkIn);
  final CheckIn checkIn;
  @override
  List<Object?> get props => [checkIn];
}

class CheckInError extends CheckInState {
  const CheckInError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
