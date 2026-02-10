import 'package:equatable/equatable.dart';

import '../../../../domain/entities/check_in.dart';
import '../../../../domain/entities/recommendation.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  const HomeLoaded({
    this.latestCheckIn,
    this.recommendations = const [],
    this.contextDayTitleKey,
    this.contextDaySubtitleKey,
    this.contextDaySubtitleParam,
    this.microInsightKey,
  });
  final CheckIn? latestCheckIn;
  final List<Recommendation> recommendations;
  final String? contextDayTitleKey;
  final String? contextDaySubtitleKey;
  final String? contextDaySubtitleParam;
  final String? microInsightKey;

  @override
  List<Object?> get props => [
        latestCheckIn,
        recommendations,
        contextDayTitleKey,
        contextDaySubtitleKey,
        contextDaySubtitleParam,
        microInsightKey,
      ];
}

class HomeError extends HomeState {
  const HomeError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
