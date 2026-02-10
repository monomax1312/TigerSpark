import 'package:equatable/equatable.dart';

class EnergySummary extends Equatable {
  const EnergySummary({
    required this.date,
    required this.averageEnergy,
    required this.checkInCount,
    this.peakHour,
    this.lowestHour,
    this.fluctuationLevel,
  });

  final DateTime date;
  final double averageEnergy;
  final int checkInCount;
  final int? peakHour;
  final int? lowestHour;
  final String? fluctuationLevel;

  @override
  List<Object?> get props => [date, averageEnergy, checkInCount, peakHour, lowestHour, fluctuationLevel];
}
