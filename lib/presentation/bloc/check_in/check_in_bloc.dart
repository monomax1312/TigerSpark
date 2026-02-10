import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/logger/app_logger.dart';
import '../../../../domain/usecases/add_check_in.dart';
import 'check_in_event.dart';
import 'check_in_state.dart';

class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  CheckInBloc(this._addCheckIn, this._logger) : super(const CheckInIdle()) {
    on<CheckInSubmitted>(_onSubmitted);
    on<CheckInScreenOpened>(_onOpened);
  }

  final AddCheckIn _addCheckIn;
  final AppLogger _logger;

  void _onOpened(CheckInScreenOpened event, Emitter<CheckInState> emit) {
    emit(const CheckInIdle());
  }

  Future<void> _onSubmitted(CheckInSubmitted event, Emitter<CheckInState> emit) async {
    emit(const CheckInSubmitting());
    try {
      final checkIn = await _addCheckIn(event.draft);
      emit(CheckInSuccess(checkIn));
    } catch (e, st) {
      _logger.error(
        'CheckInSubmitted failed',
        tag: 'CheckInBloc',
        error: e,
        stackTrace: st,
      );
      emit(CheckInError(e.toString()));
    }
  }
}
