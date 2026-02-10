import 'package:equatable/equatable.dart';

enum RecommendationKind {
  workBest,
  takePause,
  avoidDecisions,
  lightTasks,
}

class Recommendation extends Equatable {
  const Recommendation({
    required this.id,
    required this.kind,
    required this.title,
    required this.message,
    this.fromTime,
    this.toTime,
  });

  final String id;
  final RecommendationKind kind;
  final String title;
  final String message;
  final DateTime? fromTime;
  final DateTime? toTime;

  @override
  List<Object?> get props => [id, kind, title, message, fromTime, toTime];
}
