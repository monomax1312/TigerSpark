import 'package:equatable/equatable.dart';

import '../../../../domain/entities/insight.dart';

abstract class InsightsState extends Equatable {
  const InsightsState();
  @override
  List<Object?> get props => [];
}

class InsightsInitial extends InsightsState {
  const InsightsInitial();
}

class InsightsLoading extends InsightsState {
  const InsightsLoading();
}

class InsightsLoaded extends InsightsState {
  const InsightsLoaded(this.insights, {this.totalCheckInCount = 0});
  final List<Insight> insights;
  final int totalCheckInCount;
  @override
  List<Object?> get props => [insights, totalCheckInCount];
}

class InsightsError extends InsightsState {
  const InsightsError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
