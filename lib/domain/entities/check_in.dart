import 'package:equatable/equatable.dart';

enum EnergyLevel {
  veryLow(1, 'Очень низкая'),
  low(2, 'Низкая'),
  medium(3, 'Средняя'),
  high(4, 'Высокая'),
  veryHigh(5, 'Очень высокая');

  const EnergyLevel(this.value, this.label);
  final int value;
  final String label;
}

enum MoodState {
  calm('Спокойный'),
  tense('Напряжённый');

  const MoodState(this.label);
  final String label;
}

enum FocusLevel {
  low('Низкий'),
  medium('Средний'),
  high('Высокий');

  const FocusLevel(this.label);
  final String label;
}

class CheckIn extends Equatable {
  const CheckIn({
    required this.id,
    required this.energy,
    required this.mood,
    required this.focus,
    required this.at,
  });

  final String id;
  final EnergyLevel energy;
  final MoodState mood;
  final FocusLevel focus;
  final DateTime at;

  @override
  List<Object?> get props => [id, energy, mood, focus, at];
}

class CheckInDraft extends Equatable {
  const CheckInDraft({
    required this.energy,
    required this.mood,
    required this.focus,
  });

  final EnergyLevel energy;
  final MoodState mood;
  final FocusLevel focus;

  @override
  List<Object?> get props => [energy, mood, focus];
}
