import 'package:equatable/equatable.dart';

import '../../../../domain/entities/energy_summary.dart';

abstract class AnalyticsState extends Equatable {
  const AnalyticsState();
  @override
  List<Object?> get props => [];
}

class AnalyticsInitial extends AnalyticsState {
  const AnalyticsInitial();
}

class AnalyticsLoading extends AnalyticsState {
  const AnalyticsLoading();
}

class AnalyticsLoaded extends AnalyticsState {
  const AnalyticsLoaded(this.summaries, {this.summaryKey});
  final List<EnergySummary> summaries;
  final String? summaryKey;
  @override
  List<Object?> get props => [summaries, summaryKey];
}

class AnalyticsError extends AnalyticsState {
  const AnalyticsError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
