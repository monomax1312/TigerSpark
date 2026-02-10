import '../../domain/entities/check_in.dart';

class CheckInDto {
  const CheckInDto({
    required this.id,
    required this.energy,
    required this.mood,
    required this.focus,
    required this.at,
  });

  final String id;
  final int energy;
  final String mood;
  final String focus;
  final String at;

  Map<String, dynamic> toJson() => {
        'id': id,
        'energy': energy,
        'mood': mood,
        'focus': focus,
        'at': at,
      };

  static CheckInDto fromJson(Map<String, dynamic> json) => CheckInDto(
        id: json['id'] as String,
        energy: json['energy'] as int,
        mood: json['mood'] as String,
        focus: json['focus'] as String,
        at: json['at'] as String,
      );

  CheckIn toEntity() => CheckIn(
        id: id,
        energy: EnergyLevel.values.firstWhere(
          (e) => e.value == energy,
          orElse: () => EnergyLevel.medium,
        ),
        mood: MoodState.values.byName(mood),
        focus: FocusLevel.values.byName(focus),
        at: DateTime.parse(at),
      );

  static CheckInDto fromEntity(CheckIn entity) => CheckInDto(
        id: entity.id,
        energy: entity.energy.value,
        mood: entity.mood.name,
        focus: entity.focus.name,
        at: entity.at.toIso8601String(),
      );
}
