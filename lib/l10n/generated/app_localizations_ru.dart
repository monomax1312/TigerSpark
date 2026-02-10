// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Tiger Spark';

  @override
  String get homeSubtitle => 'Твоя энергия сейчас';

  @override
  String get homeCheckInPrompt => 'Отметь состояние за 5 секунд';

  @override
  String todayAt(String time) {
    return 'Сегодня в $time';
  }

  @override
  String dateShort(String day, String month, String year) {
    return '$day.$month.$year';
  }

  @override
  String get navEnergy => 'Энергия';

  @override
  String get navCheckIn => 'Чек-ин';

  @override
  String get navAnalytics => 'Аналитика';

  @override
  String get navInsights => 'Инсайты';

  @override
  String get navProfile => 'Профиль';

  @override
  String get checkInTitle => 'Быстрый чек-ин';

  @override
  String get checkInSubtitle => 'Только тапы, без текста — за 5 секунд';

  @override
  String get sectionEnergy => 'Уровень энергии';

  @override
  String get sectionMood => 'Состояние';

  @override
  String get sectionFocus => 'Фокус';

  @override
  String get moodCalm => 'Спокойный';

  @override
  String get moodTense => 'Напряжённый';

  @override
  String get focusLow => 'Низкий';

  @override
  String get focusMedium => 'Средний';

  @override
  String get focusHigh => 'Высокий';

  @override
  String get energyVeryLow => 'Очень низкая';

  @override
  String get energyLow => 'Низкая';

  @override
  String get energyMedium => 'Средняя';

  @override
  String get energyHigh => 'Высокая';

  @override
  String get energyVeryHigh => 'Очень высокая';

  @override
  String get done => 'Готово';

  @override
  String get analyticsTitle => 'Аналитика энергии';

  @override
  String get analyticsSubtitle => 'Пики и спады по дням';

  @override
  String get analyticsEmpty => 'Отмечай состояние — здесь появится график';

  @override
  String get analyticsAverage => 'Среднее';

  @override
  String get insightsTitle => 'Персональные инсайты';

  @override
  String get insightsSubtitle => 'Реальная ценность по твоим данным';

  @override
  String get profileSubtitle => 'Отслеживание энергии и персональные инсайты';

  @override
  String get settingsReminders => 'Напоминания';

  @override
  String get settingsRemindersSub => 'Напомнить о чек-ине';

  @override
  String get settingsTheme => 'Тема';

  @override
  String get settingsThemeSub => 'Системная';

  @override
  String get settingsAbout => 'О приложении';

  @override
  String settingsAboutSub(String version) {
    return 'Версия $version';
  }

  @override
  String get profileTeamMode => 'Командный режим (B2B) — в разработке';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsLanguageSystem => 'По умолчанию';

  @override
  String get settingsThemeSnackbar =>
      'Выбор темы появится в следующем обновлении.';

  @override
  String get settingsAboutDialog =>
      'Tiger Spark помогает отслеживать энергию и получать персональные инсайты. Версия 1.0.0';

  @override
  String get recWorkBestTitle => 'Хорошее время для работы';

  @override
  String get recWorkBestMessage =>
      'Сейчас у тебя обычно пик энергии — отличный момент для важных задач.';

  @override
  String get recPauseTitle => 'Время для паузы';

  @override
  String get recPauseMessage =>
      'Сейчас энергия часто на спаде — советуем короткий перерыв.';

  @override
  String get recDecisionsTitle => 'Не спеши с решениями';

  @override
  String get recDecisionsMessage =>
      'Энергия низкая — важные решения лучше отложить на потом.';

  @override
  String get recDefaultTitle => 'Всё в порядке';

  @override
  String get recDefaultMessage =>
      'Продолжай отмечать состояние — рекомендации появятся по данным.';

  @override
  String get insightEnergyPeakTitle => 'Пик энергии';

  @override
  String insightEnergyPeakBody(String start, String end) {
    return 'Твоя энергия выше всего с $start:00 до $end:00';
  }

  @override
  String get insightTenseTitle => 'Напряжение';

  @override
  String get insightTenseBody =>
      'Часто отмечаешь напряжённость. Попробуй короткие паузы или дыхательные упражнения.';

  @override
  String get insightHardTasksTitle => 'Сложные задачи';

  @override
  String get insightHardTasksBody =>
      'Лучшее время для сложных задач — утро, когда энергия и фокус выше.';

  @override
  String get insightNeedDataTitle => 'Нужно больше данных';

  @override
  String get insightNeedDataBody =>
      'Отмечай состояние несколько раз в день — через 3–5 дней появятся персональные инсайты.';

  @override
  String get recLightTasksTitle => 'Подойдут лёгкие задачи';

  @override
  String get recLightTasksMessage =>
      'Не перегружай себя сейчас — простые задачи пойдут легче.';

  @override
  String get homeContextToday => 'Сегодня';

  @override
  String get homeContextPattern => 'Паттерн';

  @override
  String homeContextUsualEnergy(String level) {
    return 'Обычно в это время твоя энергия $level';
  }

  @override
  String get homeContextPatternDip => 'В это время ты чаще чувствуешь спад';

  @override
  String get homeMicroEveningFocus =>
      'Я замечаю, что вечером у тебя чаще появляется фокус';

  @override
  String get homeMicroMorningPeak => 'Твоя энергия чаще на подъёме утром';

  @override
  String get homeMicroNotice => 'Я учусь твоим паттернам';

  @override
  String get checkInSubtitleShort => '3 нажатия · без текста · ~5 секунд';

  @override
  String get hintEnergy => 'Выбирай по ощущению, не анализируй';

  @override
  String get hintState => 'Спокойствие и напряжение — это нормально';

  @override
  String get hintFocus => 'Фокус ≠ энергия';

  @override
  String get checkInThanks => 'Спасибо, я учту это';

  @override
  String get checkInDoneRemembered => 'Готово. Я запомнил 🐯';

  @override
  String get analyticsSummaryRise => 'Энергия чаще повышается ближе к вечеру';

  @override
  String get analyticsSummaryFewData =>
      'Данных пока мало — выводы предварительные';

  @override
  String get analyticsSummaryFluctuations =>
      'У тебя заметные колебания в течение дня';

  @override
  String get analyticsDayFluctuationHigh => 'Колебания: высокие';

  @override
  String get analyticsDayFluctuationMedium => 'Колебания: средние';

  @override
  String get analyticsDayFluctuationLow => 'Стабильно';

  @override
  String get analyticsDayCheckIns => 'Чек-инов';

  @override
  String get insightsDescription =>
      'Я анализирую твои данные и ищу повторяющиеся паттерны';

  @override
  String insightsProgressText(String percent) {
    return 'Собрано данных: $percent%';
  }

  @override
  String get insightsProgressHint => 'Обычно инсайты появляются через 3–5 дней';

  @override
  String get insightsLockedTitle => 'Ты лучше концентрируешься после отдыха';

  @override
  String insightsLockedAfter(String count) {
    return 'Доступно после ещё $count чек-инов';
  }

  @override
  String get profileEnergyStyle => 'Твой стиль';

  @override
  String get profileEnergyWaves => 'Энергия: волнами';

  @override
  String get profileFocusMedium => 'Фокус: средний';

  @override
  String get profileBestTimeEvening => 'Лучшее время: вечер';

  @override
  String get profileStatsTitle => 'Статистика';

  @override
  String get profileStatsDays => 'Ты с нами';

  @override
  String get profileStatsCheckIns => 'Чек-инов';

  @override
  String get profileStatsInsights => 'Инсайтов';

  @override
  String get energyLevelMedium => 'средняя';

  @override
  String get energyLevelHigh => 'высокая';

  @override
  String get energyLevelLow => 'низкая';

  @override
  String get errorUnknown => 'Что-то пошло не так. Попробуйте ещё раз.';

  @override
  String get errorData => 'Некорректные данные. Попробуйте ещё раз.';

  @override
  String get errorNetwork => 'Нет соединения. Проверьте сеть.';
}
