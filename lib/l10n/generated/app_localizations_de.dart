// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Tiger Spark';

  @override
  String get homeSubtitle => 'Deine Energie jetzt';

  @override
  String get homeCheckInPrompt => 'Erfasse deinen Zustand in 5 Sekunden';

  @override
  String todayAt(String time) {
    return 'Heute um $time';
  }

  @override
  String dateShort(String day, String month, String year) {
    return '$day.$month.$year';
  }

  @override
  String get navEnergy => 'Energie';

  @override
  String get navCheckIn => 'Check-in';

  @override
  String get navAnalytics => 'Analytik';

  @override
  String get navInsights => 'Erkenntnisse';

  @override
  String get navProfile => 'Profil';

  @override
  String get checkInTitle => 'Schneller Check-in';

  @override
  String get checkInSubtitle => 'Nur Tippen, kein Text — 5 Sekunden';

  @override
  String get sectionEnergy => 'Energielevel';

  @override
  String get sectionMood => 'Zustand';

  @override
  String get sectionFocus => 'Fokus';

  @override
  String get moodCalm => 'Ruhig';

  @override
  String get moodTense => 'Angespannt';

  @override
  String get focusLow => 'Niedrig';

  @override
  String get focusMedium => 'Mittel';

  @override
  String get focusHigh => 'Hoch';

  @override
  String get energyVeryLow => 'Sehr niedrig';

  @override
  String get energyLow => 'Niedrig';

  @override
  String get energyMedium => 'Mittel';

  @override
  String get energyHigh => 'Hoch';

  @override
  String get energyVeryHigh => 'Sehr hoch';

  @override
  String get done => 'Fertig';

  @override
  String get analyticsTitle => 'Energie-Analytik';

  @override
  String get analyticsSubtitle => 'Hochs und Tiefs nach Tag';

  @override
  String get analyticsEmpty =>
      'Erfasse deinen Zustand — hier erscheint die Grafik';

  @override
  String get analyticsAverage => 'Durchschnitt';

  @override
  String get insightsTitle => 'Persönliche Erkenntnisse';

  @override
  String get insightsSubtitle => 'Echter Mehrwert aus deinen Daten';

  @override
  String get profileSubtitle => 'Energie-Tracking und persönliche Erkenntnisse';

  @override
  String get settingsReminders => 'Erinnerungen';

  @override
  String get settingsRemindersSub => 'An Check-in erinnern';

  @override
  String get settingsTheme => 'Design';

  @override
  String get settingsThemeSub => 'System';

  @override
  String get settingsAbout => 'Über die App';

  @override
  String settingsAboutSub(String version) {
    return 'Version $version';
  }

  @override
  String get profileTeamMode => 'Team-Modus (B2B) — in Entwicklung';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsLanguageSystem => 'Systemstandard';

  @override
  String get settingsThemeSnackbar =>
      'Design-Auswahl kommt in einem zukünftigen Update.';

  @override
  String get settingsAboutDialog =>
      'Tiger Spark hilft dir, deine Energie zu tracken und persönliche Erkenntnisse zu erhalten. Version 1.0.0';

  @override
  String get recWorkBestTitle => 'Gute Zeit zum Arbeiten';

  @override
  String get recWorkBestMessage =>
      'Deine Energie ist jetzt meist am höchsten — ideal für wichtige Aufgaben.';

  @override
  String get recPauseTitle => 'Pausenzeit';

  @override
  String get recPauseMessage =>
      'Die Energie sinkt jetzt oft — eine kurze Pause wird empfohlen.';

  @override
  String get recDecisionsTitle => 'Entscheidungen nicht überstürzen';

  @override
  String get recDecisionsMessage =>
      'Energie ist niedrig — wichtige Entscheidungen besser verschieben.';

  @override
  String get recDefaultTitle => 'Alles gut';

  @override
  String get recDefaultMessage =>
      'Erfasse weiter deinen Zustand — Empfehlungen erscheinen mit mehr Daten.';

  @override
  String get insightEnergyPeakTitle => 'Energie-Hoch';

  @override
  String insightEnergyPeakBody(String start, String end) {
    return 'Deine Energie ist zwischen $start:00 und $end:00 am höchsten';
  }

  @override
  String get insightTenseTitle => 'Anspannung';

  @override
  String get insightTenseBody =>
      'Du markierst oft Anspannung. Probiere kurze Pausen oder Atemübungen.';

  @override
  String get insightHardTasksTitle => 'Schwierige Aufgaben';

  @override
  String get insightHardTasksBody =>
      'Beste Zeit für schwierige Aufgaben ist morgens, wenn Energie und Fokus höher sind.';

  @override
  String get insightNeedDataTitle => 'Mehr Daten nötig';

  @override
  String get insightNeedDataBody =>
      'Erfasse mehrmals täglich deinen Zustand — persönliche Erkenntnisse erscheinen in 3–5 Tagen.';

  @override
  String get recLightTasksTitle => 'Leichte Aufgaben passen';

  @override
  String get recLightTasksMessage =>
      'Überfordere dich jetzt nicht — einfachere Aufgaben gehen besser.';

  @override
  String get homeContextToday => 'Heute';

  @override
  String get homeContextPattern => 'Muster';

  @override
  String homeContextUsualEnergy(String level) {
    return 'Um diese Zeit ist deine Energie meist $level';
  }

  @override
  String get homeContextPatternDip => 'Zu dieser Zeit spürst du oft ein Tief';

  @override
  String get homeMicroEveningFocus =>
      'Ich merke, abends hast du oft mehr Fokus';

  @override
  String get homeMicroMorningPeak => 'Deine Energie steigt morgens oft';

  @override
  String get homeMicroNotice => 'Ich lerne deine Muster';

  @override
  String get checkInSubtitleShort => '3 Tipps · kein Text · ~5 Sekunden';

  @override
  String get hintEnergy => 'Geh nach Gefühl, nicht nach Analyse';

  @override
  String get hintState => 'Ruhig und angespannt sind beides normal';

  @override
  String get hintFocus => 'Fokus ≠ Energie';

  @override
  String get checkInThanks => 'Danke, ich merke mir das';

  @override
  String get checkInDoneRemembered => 'Fertig. Ich habe es mir gemerkt 🐯';

  @override
  String get analyticsSummaryRise => 'Energie steigt oft zum Abend';

  @override
  String get analyticsSummaryFewData =>
      'Noch wenig Daten — Erkenntnisse vorläufig';

  @override
  String get analyticsSummaryFluctuations =>
      'Du hast deutliche Schwankungen im Tag';

  @override
  String get analyticsDayFluctuationHigh => 'Starke Schwankung';

  @override
  String get analyticsDayFluctuationMedium => 'Mittlere Schwankung';

  @override
  String get analyticsDayFluctuationLow => 'Stabil';

  @override
  String get analyticsDayCheckIns => 'Check-ins';

  @override
  String get insightsDescription =>
      'Ich analysiere deine Daten und suche wiederkehrende Muster';

  @override
  String insightsProgressText(String percent) {
    return 'Daten gesammelt: $percent%';
  }

  @override
  String get insightsProgressHint =>
      'Erkenntnisse erscheinen meist nach 3–5 Tagen';

  @override
  String get insightsLockedTitle => 'Du konzentrierst dich besser nach Pausen';

  @override
  String insightsLockedAfter(String count) {
    return 'Verfügbar nach $count weiteren Check-ins';
  }

  @override
  String get profileEnergyStyle => 'Dein Energie-Stil';

  @override
  String get profileEnergyWaves => 'Energie: in Wellen';

  @override
  String get profileFocusMedium => 'Fokus: mittel';

  @override
  String get profileBestTimeEvening => 'Beste Zeit: Abend';

  @override
  String get profileStatsTitle => 'Statistik';

  @override
  String get profileStatsDays => 'Tage dabei';

  @override
  String get profileStatsCheckIns => 'Check-ins';

  @override
  String get profileStatsInsights => 'Erkenntnisse';

  @override
  String get energyLevelMedium => 'mittel';

  @override
  String get energyLevelHigh => 'hoch';

  @override
  String get energyLevelLow => 'niedrig';

  @override
  String get errorUnknown =>
      'Etwas ist schiefgelaufen. Bitte erneut versuchen.';

  @override
  String get errorData => 'Ungültige Daten. Bitte erneut versuchen.';

  @override
  String get errorNetwork => 'Keine Verbindung. Netzwerk prüfen.';
}
