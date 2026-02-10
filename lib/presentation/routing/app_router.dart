import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/screens/analytics_screen.dart';
import '../ui/widgets/main_shell.dart';
import '../ui/screens/check_in_screen.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/insights_screen.dart';
import '../ui/screens/profile_screen.dart';

enum AppRoute {
  home,
  checkIn,
  analytics,
  insights,
  profile,
}

class AppRouter {
  AppRouter._();

  static const String home = '/';
  static const String checkIn = '/check-in';
  static const String analytics = '/analytics';
  static const String insights = '/insights';
  static const String profile = '/profile';

  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: home,
      routes: [
        ShellRoute(
          builder: (context, state, _) => MainShell(location: state.uri.path),
          routes: [
            GoRoute(
              path: home,
              pageBuilder: (context, state) => _noTransition(const HomeScreen()),
            ),
            GoRoute(
              path: checkIn,
              pageBuilder: (context, state) => _noTransition(const CheckInScreen()),
            ),
            GoRoute(
              path: analytics,
              pageBuilder: (context, state) => _noTransition(const AnalyticsScreen()),
            ),
            GoRoute(
              path: insights,
              pageBuilder: (context, state) => _noTransition(const InsightsScreen()),
            ),
            GoRoute(
              path: profile,
              pageBuilder: (context, state) => _noTransition(const ProfileScreen()),
            ),
          ],
        ),
      ],
    );
  }

  static CustomTransitionPage _noTransition(Widget child) {
    return CustomTransitionPage(
      key: ValueKey(child.runtimeType),
      child: child,
      transitionsBuilder: (_, __, ___, child) => child,
    );
  }
}
