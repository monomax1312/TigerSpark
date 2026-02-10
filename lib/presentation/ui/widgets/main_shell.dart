import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/analytics_screen.dart';
import '../screens/check_in_screen.dart';
import '../screens/home_screen.dart';
import '../screens/insights_screen.dart';
import '../screens/profile_screen.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../theme/app_theme.dart';
import 'nav_item.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key, required this.location});

  final String location;

  static List<NavItem> _items(AppLocalizations l10n) => [
    NavItem(icon: Icons.bolt, label: l10n.navEnergy, path: '/'),
    NavItem(icon: Icons.touch_app, label: l10n.navCheckIn, path: '/check-in'),
    NavItem(icon: Icons.bar_chart_rounded, label: l10n.navAnalytics, path: '/analytics'),
    NavItem(icon: Icons.auto_awesome, label: l10n.navInsights, path: '/insights'),
    NavItem(icon: Icons.person_outline, label: l10n.navProfile, path: '/profile'),
  ];

  static int _indexFromPath(String path) {
    if (path == '/') return 0;
    if (path.startsWith('/check-in')) return 1;
    if (path.startsWith('/analytics')) return 2;
    if (path.startsWith('/insights')) return 3;
    if (path.startsWith('/profile')) return 4;
    return 0;
  }

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = MainShell._indexFromPath(widget.location);
  }

  @override
  void didUpdateWidget(MainShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.location != widget.location) {
      _selectedIndex = MainShell._indexFromPath(widget.location);
    }
  }

  void _onTabTap(int index, String path) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
    context.go(path);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = MainShell._items(l10n);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.yellowClarity.withValues(alpha: 0.15),
              AppTheme.surfaceLight,
            ],
          ),
        ),
        child: IndexedStack(
          index: _selectedIndex,
          children: const [
            HomeScreen(key: ValueKey('home')),
            CheckInScreen(key: ValueKey('checkin')),
            AnalyticsScreen(key: ValueKey('analytics')),
            InsightsScreen(key: ValueKey('insights')),
            ProfileScreen(key: ValueKey('profile')),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (var i = 0; i < items.length; i++)
                  _NavButton(
                    item: items[i],
                    isSelected: _selectedIndex == i,
                    onTap: () => _onTabTap(i, items[i].path),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            gradient: isSelected ? AppTheme.primaryGradient : null,
            color: isSelected ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppTheme.orangePrimary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                item.icon,
                size: 22,
                color: isSelected ? AppTheme.white : AppTheme.textSecondary,
              ),
              const SizedBox(height: 4),
              Text(
                item.label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? AppTheme.white : AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
