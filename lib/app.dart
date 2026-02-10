import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'presentation/settings/locale_controller.dart';
import 'l10n/generated/app_localizations.dart';
import 'presentation/bloc/analytics/analytics_bloc.dart';
import 'presentation/bloc/check_in/check_in_bloc.dart';
import 'presentation/bloc/home/home_bloc.dart';
import 'presentation/bloc/insights/insights_bloc.dart';
import 'presentation/routing/app_router.dart';
import 'presentation/theme/app_theme.dart';

class TigerSparkApp extends StatelessWidget {
  const TigerSparkApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = getIt<LocaleController>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (_) => getIt<HomeBloc>()),
        BlocProvider<CheckInBloc>(create: (_) => getIt<CheckInBloc>()),
        BlocProvider<AnalyticsBloc>(create: (_) => getIt<AnalyticsBloc>()),
        BlocProvider<InsightsBloc>(create: (_) => getIt<InsightsBloc>()),
      ],
      child: ListenableBuilder(
        listenable: localeController,
        builder: (context, _) => MaterialApp.router(
          title: 'Tiger Spark',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          locale: localeController.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: AppRouter.createRouter(),
        ),
      ),
    );
  }
}
