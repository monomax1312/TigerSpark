import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Tiger Spark'**
  String get appTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your energy right now'**
  String get homeSubtitle;

  /// No description provided for @homeCheckInPrompt.
  ///
  /// In en, this message translates to:
  /// **'Log your state in 5 seconds'**
  String get homeCheckInPrompt;

  /// No description provided for @todayAt.
  ///
  /// In en, this message translates to:
  /// **'Today at {time}'**
  String todayAt(String time);

  /// No description provided for @dateShort.
  ///
  /// In en, this message translates to:
  /// **'{day}.{month}.{year}'**
  String dateShort(String day, String month, String year);

  /// No description provided for @navEnergy.
  ///
  /// In en, this message translates to:
  /// **'Energy'**
  String get navEnergy;

  /// No description provided for @navCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get navCheckIn;

  /// No description provided for @navAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get navAnalytics;

  /// No description provided for @navInsights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get navInsights;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @checkInTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick check-in'**
  String get checkInTitle;

  /// No description provided for @checkInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Taps only, no typing — 5 seconds'**
  String get checkInSubtitle;

  /// No description provided for @sectionEnergy.
  ///
  /// In en, this message translates to:
  /// **'Energy level'**
  String get sectionEnergy;

  /// No description provided for @sectionMood.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get sectionMood;

  /// No description provided for @sectionFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get sectionFocus;

  /// No description provided for @moodCalm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get moodCalm;

  /// No description provided for @moodTense.
  ///
  /// In en, this message translates to:
  /// **'Tense'**
  String get moodTense;

  /// No description provided for @focusLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get focusLow;

  /// No description provided for @focusMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get focusMedium;

  /// No description provided for @focusHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get focusHigh;

  /// No description provided for @energyVeryLow.
  ///
  /// In en, this message translates to:
  /// **'Very low'**
  String get energyVeryLow;

  /// No description provided for @energyLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get energyLow;

  /// No description provided for @energyMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get energyMedium;

  /// No description provided for @energyHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get energyHigh;

  /// No description provided for @energyVeryHigh.
  ///
  /// In en, this message translates to:
  /// **'Very high'**
  String get energyVeryHigh;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @analyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Energy analytics'**
  String get analyticsTitle;

  /// No description provided for @analyticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Peaks and dips by day'**
  String get analyticsSubtitle;

  /// No description provided for @analyticsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Log your state — the chart will appear here'**
  String get analyticsEmpty;

  /// No description provided for @analyticsAverage.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get analyticsAverage;

  /// No description provided for @insightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal insights'**
  String get insightsTitle;

  /// No description provided for @insightsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Real value from your data'**
  String get insightsSubtitle;

  /// No description provided for @profileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Energy tracking and personal insights'**
  String get profileSubtitle;

  /// No description provided for @settingsReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get settingsReminders;

  /// No description provided for @settingsRemindersSub.
  ///
  /// In en, this message translates to:
  /// **'Remind to check in'**
  String get settingsRemindersSub;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeSub.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSub;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsAboutSub.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String settingsAboutSub(String version);

  /// No description provided for @profileTeamMode.
  ///
  /// In en, this message translates to:
  /// **'Team mode (B2B) — coming soon'**
  String get profileTeamMode;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsThemeSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Theme selection coming in a future update.'**
  String get settingsThemeSnackbar;

  /// No description provided for @settingsAboutDialog.
  ///
  /// In en, this message translates to:
  /// **'Tiger Spark helps you track your energy and get personal insights. Version 1.0.0'**
  String get settingsAboutDialog;

  /// No description provided for @recWorkBestTitle.
  ///
  /// In en, this message translates to:
  /// **'Good time to work'**
  String get recWorkBestTitle;

  /// No description provided for @recWorkBestMessage.
  ///
  /// In en, this message translates to:
  /// **'Your energy is usually at its peak now — great for important tasks.'**
  String get recWorkBestMessage;

  /// No description provided for @recPauseTitle.
  ///
  /// In en, this message translates to:
  /// **'Time for a break'**
  String get recPauseTitle;

  /// No description provided for @recPauseMessage.
  ///
  /// In en, this message translates to:
  /// **'Energy often dips now — a short break is recommended.'**
  String get recPauseMessage;

  /// No description provided for @recDecisionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Don\'t rush decisions'**
  String get recDecisionsTitle;

  /// No description provided for @recDecisionsMessage.
  ///
  /// In en, this message translates to:
  /// **'Energy is low — better to postpone important decisions.'**
  String get recDecisionsMessage;

  /// No description provided for @recDefaultTitle.
  ///
  /// In en, this message translates to:
  /// **'All good'**
  String get recDefaultTitle;

  /// No description provided for @recDefaultMessage.
  ///
  /// In en, this message translates to:
  /// **'Keep logging your state — recommendations will appear as data grows.'**
  String get recDefaultMessage;

  /// No description provided for @insightEnergyPeakTitle.
  ///
  /// In en, this message translates to:
  /// **'Energy peak'**
  String get insightEnergyPeakTitle;

  /// No description provided for @insightEnergyPeakBody.
  ///
  /// In en, this message translates to:
  /// **'Your energy is highest between {start}:00 and {end}:00'**
  String insightEnergyPeakBody(String start, String end);

  /// No description provided for @insightTenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Tension'**
  String get insightTenseTitle;

  /// No description provided for @insightTenseBody.
  ///
  /// In en, this message translates to:
  /// **'You often mark tension. Try short breaks or breathing exercises.'**
  String get insightTenseBody;

  /// No description provided for @insightHardTasksTitle.
  ///
  /// In en, this message translates to:
  /// **'Hard tasks'**
  String get insightHardTasksTitle;

  /// No description provided for @insightHardTasksBody.
  ///
  /// In en, this message translates to:
  /// **'Best time for hard tasks is morning, when energy and focus are higher.'**
  String get insightHardTasksBody;

  /// No description provided for @insightNeedDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Need more data'**
  String get insightNeedDataTitle;

  /// No description provided for @insightNeedDataBody.
  ///
  /// In en, this message translates to:
  /// **'Log your state a few times a day — personal insights will appear in 3–5 days.'**
  String get insightNeedDataBody;

  /// No description provided for @recLightTasksTitle.
  ///
  /// In en, this message translates to:
  /// **'Light tasks work best'**
  String get recLightTasksTitle;

  /// No description provided for @recLightTasksMessage.
  ///
  /// In en, this message translates to:
  /// **'Don\'t overload yourself right now — simpler tasks will go better.'**
  String get recLightTasksMessage;

  /// No description provided for @homeContextToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get homeContextToday;

  /// No description provided for @homeContextPattern.
  ///
  /// In en, this message translates to:
  /// **'Pattern'**
  String get homeContextPattern;

  /// No description provided for @homeContextUsualEnergy.
  ///
  /// In en, this message translates to:
  /// **'Usually at this time your energy is {level}'**
  String homeContextUsualEnergy(String level);

  /// No description provided for @homeContextPatternDip.
  ///
  /// In en, this message translates to:
  /// **'At this time you often feel a dip'**
  String get homeContextPatternDip;

  /// No description provided for @homeMicroEveningFocus.
  ///
  /// In en, this message translates to:
  /// **'I notice you often get more focus in the evening'**
  String get homeMicroEveningFocus;

  /// No description provided for @homeMicroMorningPeak.
  ///
  /// In en, this message translates to:
  /// **'Your energy tends to peak in the morning'**
  String get homeMicroMorningPeak;

  /// No description provided for @homeMicroNotice.
  ///
  /// In en, this message translates to:
  /// **'I\'m learning your patterns'**
  String get homeMicroNotice;

  /// No description provided for @checkInSubtitleShort.
  ///
  /// In en, this message translates to:
  /// **'3 taps · no typing · ~5 seconds'**
  String get checkInSubtitleShort;

  /// No description provided for @hintEnergy.
  ///
  /// In en, this message translates to:
  /// **'Go by feeling, don\'t overthink'**
  String get hintEnergy;

  /// No description provided for @hintState.
  ///
  /// In en, this message translates to:
  /// **'Calm and tense are both normal'**
  String get hintState;

  /// No description provided for @hintFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus ≠ energy'**
  String get hintFocus;

  /// No description provided for @checkInThanks.
  ///
  /// In en, this message translates to:
  /// **'Thanks, I\'ll keep that in mind'**
  String get checkInThanks;

  /// No description provided for @checkInDoneRemembered.
  ///
  /// In en, this message translates to:
  /// **'Done. I\'ll remember that 🐯'**
  String get checkInDoneRemembered;

  /// No description provided for @analyticsSummaryRise.
  ///
  /// In en, this message translates to:
  /// **'Energy often rises toward evening'**
  String get analyticsSummaryRise;

  /// No description provided for @analyticsSummaryFewData.
  ///
  /// In en, this message translates to:
  /// **'Not enough data yet — insights are preliminary'**
  String get analyticsSummaryFewData;

  /// No description provided for @analyticsSummaryFluctuations.
  ///
  /// In en, this message translates to:
  /// **'You have noticeable ups and downs during the day'**
  String get analyticsSummaryFluctuations;

  /// No description provided for @analyticsDayFluctuationHigh.
  ///
  /// In en, this message translates to:
  /// **'High variation'**
  String get analyticsDayFluctuationHigh;

  /// No description provided for @analyticsDayFluctuationMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium variation'**
  String get analyticsDayFluctuationMedium;

  /// No description provided for @analyticsDayFluctuationLow.
  ///
  /// In en, this message translates to:
  /// **'Stable'**
  String get analyticsDayFluctuationLow;

  /// No description provided for @analyticsDayCheckIns.
  ///
  /// In en, this message translates to:
  /// **'Check-ins'**
  String get analyticsDayCheckIns;

  /// No description provided for @insightsDescription.
  ///
  /// In en, this message translates to:
  /// **'I analyze your data and look for repeating patterns'**
  String get insightsDescription;

  /// No description provided for @insightsProgressText.
  ///
  /// In en, this message translates to:
  /// **'Data collected: {percent}%'**
  String insightsProgressText(String percent);

  /// No description provided for @insightsProgressHint.
  ///
  /// In en, this message translates to:
  /// **'Insights usually appear after 3–5 days'**
  String get insightsProgressHint;

  /// No description provided for @insightsLockedTitle.
  ///
  /// In en, this message translates to:
  /// **'You focus better after rest'**
  String get insightsLockedTitle;

  /// No description provided for @insightsLockedAfter.
  ///
  /// In en, this message translates to:
  /// **'Available after {count} more check-ins'**
  String insightsLockedAfter(String count);

  /// No description provided for @profileEnergyStyle.
  ///
  /// In en, this message translates to:
  /// **'Your energy style'**
  String get profileEnergyStyle;

  /// No description provided for @profileEnergyWaves.
  ///
  /// In en, this message translates to:
  /// **'Energy: in waves'**
  String get profileEnergyWaves;

  /// No description provided for @profileFocusMedium.
  ///
  /// In en, this message translates to:
  /// **'Focus: medium'**
  String get profileFocusMedium;

  /// No description provided for @profileBestTimeEvening.
  ///
  /// In en, this message translates to:
  /// **'Best time: evening'**
  String get profileBestTimeEvening;

  /// No description provided for @profileStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get profileStatsTitle;

  /// No description provided for @profileStatsDays.
  ///
  /// In en, this message translates to:
  /// **'Days with us'**
  String get profileStatsDays;

  /// No description provided for @profileStatsCheckIns.
  ///
  /// In en, this message translates to:
  /// **'Check-ins'**
  String get profileStatsCheckIns;

  /// No description provided for @profileStatsInsights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get profileStatsInsights;

  /// No description provided for @energyLevelMedium.
  ///
  /// In en, this message translates to:
  /// **'medium'**
  String get energyLevelMedium;

  /// No description provided for @energyLevelHigh.
  ///
  /// In en, this message translates to:
  /// **'high'**
  String get energyLevelHigh;

  /// No description provided for @energyLevelLow.
  ///
  /// In en, this message translates to:
  /// **'low'**
  String get energyLevelLow;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorUnknown;

  /// No description provided for @errorData.
  ///
  /// In en, this message translates to:
  /// **'Invalid data. Please try again.'**
  String get errorData;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'No connection. Check your network.'**
  String get errorNetwork;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
