import 'package:equatable/equatable.dart';

enum InsightType {
  energyPeakTime,
  energyDropAfterMeetings,
  bestTimeForHardTasks,
  pauseRecommendation,
  decisionTimeWarning,
  custom,
}

class Insight extends Equatable {
  const Insight({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    this.iconName,
    this.priority,
    this.generatedAt,
    this.formatParams,
  });

  final String id;
  final InsightType type;
  final String title;
  final String body;
  final String? iconName;
  final int? priority;
  final DateTime? generatedAt;
  /// Параметры для локализованной подстановки (напр. start, end для energyPeakTime).
  final Map<String, String>? formatParams;

  @override
  List<Object?> get props => [id, type, title, body, iconName, priority, generatedAt, formatParams];
}
