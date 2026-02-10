import '../../domain/entities/check_in.dart';
import '../../l10n/generated/app_localizations.dart';

String localizedMood(AppLocalizations l10n, MoodState mood) {
  switch (mood) {
    case MoodState.calm:
      return l10n.moodCalm;
    case MoodState.tense:
      return l10n.moodTense;
  }
}

String localizedFocus(AppLocalizations l10n, FocusLevel focus) {
  switch (focus) {
    case FocusLevel.low:
      return l10n.focusLow;
    case FocusLevel.medium:
      return l10n.focusMedium;
    case FocusLevel.high:
      return l10n.focusHigh;
  }
}

String localizedEnergyLevel(AppLocalizations l10n, EnergyLevel level) {
  switch (level) {
    case EnergyLevel.veryLow:
      return l10n.energyVeryLow;
    case EnergyLevel.low:
      return l10n.energyLow;
    case EnergyLevel.medium:
      return l10n.energyMedium;
    case EnergyLevel.high:
      return l10n.energyHigh;
    case EnergyLevel.veryHigh:
      return l10n.energyVeryHigh;
  }
}
