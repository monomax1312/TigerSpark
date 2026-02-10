import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../logger/app_logger.dart';
import '../../data/local/check_in_storage.dart';
import '../../data/repositories/check_in_repository_impl.dart';
import '../../data/repositories/insight_repository_impl.dart';
import '../../data/repositories/recommendation_repository_impl.dart';
import '../../domain/repositories/check_in_repository.dart';
import '../../domain/repositories/insight_repository.dart';
import '../../domain/repositories/recommendation_repository.dart';
import '../../domain/usecases/add_check_in.dart';
import '../../domain/usecases/get_check_ins.dart';
import '../../domain/usecases/get_energy_summaries.dart';
import '../../domain/usecases/get_insights.dart';
import '../../domain/usecases/get_latest_check_in.dart';
import '../../domain/usecases/get_recommendations.dart';
import '../../presentation/settings/locale_controller.dart';
import '../../presentation/bloc/analytics/analytics_bloc.dart';
import '../../presentation/bloc/check_in/check_in_bloc.dart';
import '../../presentation/bloc/home/home_bloc.dart';
import '../../presentation/bloc/insights/insights_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupInjection() async {
  getIt.registerSingleton<AppLogger>(AppLoggerImpl());
  getIt.registerSingleton<LocaleController>(LocaleController());

  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  getIt.registerSingleton<CheckInStorage>(CheckInStorage(getIt<SharedPreferences>()));

  getIt.registerSingleton<CheckInRepository>(
    CheckInRepositoryImpl(getIt<CheckInStorage>()),
  );
  getIt.registerSingleton<InsightRepository>(
    InsightRepositoryImpl(getIt<CheckInRepository>()),
  );
  getIt.registerSingleton<RecommendationRepository>(
    RecommendationRepositoryImpl(getIt<CheckInRepository>()),
  );

  getIt.registerSingleton<AddCheckIn>(AddCheckIn(getIt<CheckInRepository>()));
  getIt.registerSingleton<GetCheckIns>(GetCheckIns(getIt<CheckInRepository>()));
  getIt.registerSingleton<GetLatestCheckIn>(GetLatestCheckIn(getIt<CheckInRepository>()));
  getIt.registerSingleton<GetEnergySummaries>(GetEnergySummaries(getIt<CheckInRepository>()));
  getIt.registerSingleton<GetInsights>(GetInsights(getIt<InsightRepository>()));
  getIt.registerSingleton<GetRecommendations>(GetRecommendations(getIt<RecommendationRepository>()));

  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(
      getIt<GetLatestCheckIn>(),
      getIt<GetRecommendations>(),
      getIt<GetCheckIns>(),
      getIt<GetEnergySummaries>(),
      getIt<AppLogger>(),
    ),
  );
  getIt.registerFactory<CheckInBloc>(
    () => CheckInBloc(getIt<AddCheckIn>(), getIt<AppLogger>()),
  );
  getIt.registerFactory<AnalyticsBloc>(
    () => AnalyticsBloc(getIt<GetEnergySummaries>(), getIt<AppLogger>()),
  );
  getIt.registerFactory<InsightsBloc>(
    () => InsightsBloc(
      getIt<GetInsights>(),
      getIt<GetCheckIns>(),
      getIt<AppLogger>(),
    ),
  );
}
