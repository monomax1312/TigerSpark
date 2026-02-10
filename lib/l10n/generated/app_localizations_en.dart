// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tiger Spark';

  @override
  String get homeSubtitle => 'Your energy right now';

  @override
  String get homeCheckInPrompt => 'Log your state in 5 seconds';

  @override
  String todayAt(String time) {
    return 'Today at $time';
  }

  @override
  String dateShort(String day, String month, String year) {
    return '$day.$month.$year';
  }

  @override
  String get navEnergy => 'Energy';

  @override
  String get navCheckIn => 'Check-in';

  @override
  String get navAnalytics => 'Analytics';

  @override
  String get navInsights => 'Insights';

  @override
  String get navProfile => 'Profile';

  @override
  String get checkInTitle => 'Quick check-in';

  @override
  String get checkInSubtitle => 'Taps only, no typing — 5 seconds';

  @override
  String get sectionEnergy => 'Energy level';

  @override
  String get sectionMood => 'State';

  @override
  String get sectionFocus => 'Focus';

  @override
  String get moodCalm => 'Calm';

  @override
  String get moodTense => 'Tense';

  @override
  String get focusLow => 'Low';

  @override
  String get focusMedium => 'Medium';

  @override
  String get focusHigh => 'High';

  @override
  String get energyVeryLow => 'Very low';

  @override
  String get energyLow => 'Low';

  @override
  String get energyMedium => 'Medium';

  @override
  String get energyHigh => 'High';

  @override
  String get energyVeryHigh => 'Very high';

  @override
  String get done => 'Done';

  @override
  String get analyticsTitle => 'Energy analytics';

  @override
  String get analyticsSubtitle => 'Peaks and dips by day';

  @override
  String get analyticsEmpty => 'Log your state — the chart will appear here';

  @override
  String get analyticsAverage => 'Average';

  @override
  String get insightsTitle => 'Personal insights';

  @override
  String get insightsSubtitle => 'Real value from your data';

  @override
  String get profileSubtitle => 'Energy tracking and personal insights';

  @override
  String get settingsReminders => 'Reminders';

  @override
  String get settingsRemindersSub => 'Remind to check in';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeSub => 'System';

  @override
  String get settingsAbout => 'About';

  @override
  String settingsAboutSub(String version) {
    return 'Version $version';
  }

  @override
  String get profileTeamMode => 'Team mode (B2B) — coming soon';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'System default';

  @override
  String get settingsThemeSnackbar =>
      'Theme selection coming in a future update.';

  @override
  String get settingsAboutDialog =>
      'Tiger Spark helps you track your energy and get personal insights. Version 1.0.0';

  @override
  String get recWorkBestTitle => 'Good time to work';

  @override
  String get recWorkBestMessage =>
      'Your energy is usually at its peak now — great for important tasks.';

  @override
  String get recPauseTitle => 'Time for a break';

  @override
  String get recPauseMessage =>
      'Energy often dips now — a short break is recommended.';

  @override
  String get recDecisionsTitle => 'Don\'t rush decisions';

  @override
  String get recDecisionsMessage =>
      'Energy is low — better to postpone important decisions.';

  @override
  String get recDefaultTitle => 'All good';

  @override
  String get recDefaultMessage =>
      'Keep logging your state — recommendations will appear as data grows.';

  @override
  String get insightEnergyPeakTitle => 'Energy peak';

  @override
  String insightEnergyPeakBody(String start, String end) {
    return 'Your energy is highest between $start:00 and $end:00';
  }

  @override
  String get insightTenseTitle => 'Tension';

  @override
  String get insightTenseBody =>
      'You often mark tension. Try short breaks or breathing exercises.';

  @override
  String get insightHardTasksTitle => 'Hard tasks';

  @override
  String get insightHardTasksBody =>
      'Best time for hard tasks is morning, when energy and focus are higher.';

  @override
  String get insightNeedDataTitle => 'Need more data';

  @override
  String get insightNeedDataBody =>
      'Log your state a few times a day — personal insights will appear in 3–5 days.';

  @override
  String get recLightTasksTitle => 'Light tasks work best';

  @override
  String get recLightTasksMessage =>
      'Don\'t overload yourself right now — simpler tasks will go better.';

  @override
  String get homeContextToday => 'Today';

  @override
  String get homeContextPattern => 'Pattern';

  @override
  String homeContextUsualEnergy(String level) {
    return 'Usually at this time your energy is $level';
  }

  @override
  String get homeContextPatternDip => 'At this time you often feel a dip';

  @override
  String get homeMicroEveningFocus =>
      'I notice you often get more focus in the evening';

  @override
  String get homeMicroMorningPeak => 'Your energy tends to peak in the morning';

  @override
  String get homeMicroNotice => 'I\'m learning your patterns';

  @override
  String get checkInSubtitleShort => '3 taps · no typing · ~5 seconds';

  @override
  String get hintEnergy => 'Go by feeling, don\'t overthink';

  @override
  String get hintState => 'Calm and tense are both normal';

  @override
  String get hintFocus => 'Focus ≠ energy';

  @override
  String get checkInThanks => 'Thanks, I\'ll keep that in mind';

  @override
  String get checkInDoneRemembered => 'Done. I\'ll remember that 🐯';

  @override
  String get analyticsSummaryRise => 'Energy often rises toward evening';

  @override
  String get analyticsSummaryFewData =>
      'Not enough data yet — insights are preliminary';

  @override
  String get analyticsSummaryFluctuations =>
      'You have noticeable ups and downs during the day';

  @override
  String get analyticsDayFluctuationHigh => 'High variation';

  @override
  String get analyticsDayFluctuationMedium => 'Medium variation';

  @override
  String get analyticsDayFluctuationLow => 'Stable';

  @override
  String get analyticsDayCheckIns => 'Check-ins';

  @override
  String get insightsDescription =>
      'I analyze your data and look for repeating patterns';

  @override
  String insightsProgressText(String percent) {
    return 'Data collected: $percent%';
  }

  @override
  String get insightsProgressHint => 'Insights usually appear after 3–5 days';

  @override
  String get insightsLockedTitle => 'You focus better after rest';

  @override
  String insightsLockedAfter(String count) {
    return 'Available after $count more check-ins';
  }

  @override
  String get profileEnergyStyle => 'Your energy style';

  @override
  String get profileEnergyWaves => 'Energy: in waves';

  @override
  String get profileFocusMedium => 'Focus: medium';

  @override
  String get profileBestTimeEvening => 'Best time: evening';

  @override
  String get profileStatsTitle => 'Statistics';

  @override
  String get profileStatsDays => 'Days with us';

  @override
  String get profileStatsCheckIns => 'Check-ins';

  @override
  String get profileStatsInsights => 'Insights';

  @override
  String get energyLevelMedium => 'medium';

  @override
  String get energyLevelHigh => 'high';

  @override
  String get energyLevelLow => 'low';

  @override
  String get errorUnknown => 'Something went wrong. Please try again.';

  @override
  String get errorData => 'Invalid data. Please try again.';

  @override
  String get errorNetwork => 'No connection. Check your network.';
}
