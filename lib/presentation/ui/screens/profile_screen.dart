import 'package:flutter/material.dart';

import '../../../core/di/injection.dart';
import '../../../domain/usecases/get_check_ins.dart';
import '../../../domain/usecases/get_insights.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../settings/locale_controller.dart';
import '../../theme/app_theme.dart';
import '../widgets/tiger_mascot.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _daysWithApp = 0;
  int _checkInCount = 0;
  int _insightCount = 0;
  bool _statsLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final getCheckIns = getIt<GetCheckIns>();
    final getInsights = getIt<GetInsights>();
    final now = DateTime.now();
    final checkIns = await getCheckIns(
      from: DateTime(now.year - 1),
      to: now,
    );
    final insights = await getInsights();
    DateTime? firstDate;
    for (final c in checkIns) {
      if (firstDate == null || c.at.isBefore(firstDate)) firstDate = c.at;
    }
    if (!mounted) return;
    setState(() {
      _checkInCount = checkIns.length;
      _insightCount = insights.length;
      _daysWithApp = firstDate != null
          ? now.difference(DateTime(firstDate.year, firstDate.month, firstDate.day)).inDays
          : 0;
      _statsLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeController = getIt<LocaleController>();
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
        child: Column(
          children: [
            const TigerMascot(size: 90, showGlow: true),
            const SizedBox(height: 12),
            Text(
              l10n.appTitle,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.profileSubtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _EnergyProfileCard(),
            const SizedBox(height: 16),
            _StatsCard(
              daysWithApp: _daysWithApp,
              checkInCount: _checkInCount,
              insightCount: _insightCount,
              loaded: _statsLoaded,
            ),
            const SizedBox(height: 24),
            _SettingsCard(
              children: [
                _SettingsRow(
                  icon: Icons.language,
                  title: l10n.settingsLanguage,
                  subtitle: _currentLanguageName(context, localeController.locale),
                  onTap: () => _showLanguageSheet(context, localeController),
                ),
                Divider(height: 1, color: Colors.grey.shade200),
                _SettingsRow(
                  icon: Icons.info_outline,
                  title: l10n.settingsAbout,
                  subtitle: l10n.settingsAboutSub('1.0.0'),
                  onTap: () => _showAboutDialog(context),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              l10n.profileTeamMode,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _currentLanguageName(BuildContext context, Locale? locale) {
    if (locale == null) return AppLocalizations.of(context)!.settingsLanguageSystem;
    switch (locale.languageCode) {
      case 'ru':
        return 'Русский';
      case 'de':
        return 'Deutsch';
      default:
        return 'English';
    }
  }

  void _showLanguageSheet(BuildContext context, LocaleController controller) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: AppTheme.orangePrimary.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.settingsLanguage,
              style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 16),
            _LanguageTile(
              label: 'Русский',
              locale: const Locale('ru'),
              current: controller.locale,
              onTap: () {
                controller.setLocale(const Locale('ru'));
                Navigator.pop(ctx);
              },
            ),
            _LanguageTile(
              label: 'English',
              locale: const Locale('en'),
              current: controller.locale,
              onTap: () {
                controller.setLocale(const Locale('en'));
                Navigator.pop(ctx);
              },
            ),
            _LanguageTile(
              label: 'Deutsch',
              locale: const Locale('de'),
              current: controller.locale,
              onTap: () {
                controller.setLocale(const Locale('de'));
                Navigator.pop(ctx);
              },
            ),
            _LanguageTile(
              label: l10n.settingsLanguageSystem,
              locale: null,
              current: controller.locale,
              onTap: () {
                controller.setLocale(null);
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.settingsAbout),
        content: Text(l10n.settingsAboutDialog),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.done),
          ),
        ],
      ),
    );
  }
}

class _EnergyProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '⚡ ${l10n.profileEnergyStyle}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '• ${l10n.profileEnergyWaves}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
          Text(
            '• ${l10n.profileFocusMedium}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
          Text(
            '• ${l10n.profileBestTimeEvening}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({
    required this.daysWithApp,
    required this.checkInCount,
    required this.insightCount,
    required this.loaded,
  });

  final int daysWithApp;
  final int checkInCount;
  final int insightCount;
  final bool loaded;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📊 ${l10n.profileStatsTitle}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
          ),
          const SizedBox(height: 8),
          if (loaded) ...[
            _StatRow(icon: '📅', label: '${l10n.profileStatsDays}: $daysWithApp'),
            _StatRow(icon: '✍️', label: '${l10n.profileStatsCheckIns}: $checkInCount'),
            _StatRow(icon: '🧠', label: '${l10n.profileStatsInsights}: $insightCount'),
          ] else
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppTheme.orangePrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.icon, required this.label});

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.label,
    required this.locale,
    required this.current,
    required this.onTap,
  });

  final String label;
  final Locale? locale;
  final Locale? current;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = locale == null
        ? current == null
        : (current != null && current!.languageCode == locale!.languageCode);
    return ListTile(
      title: Text(label),
      trailing: isSelected ? Icon(Icons.check, color: AppTheme.orangePrimary) : null,
      onTap: onTap,
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.cardDecoration(),
      child: Column(children: children),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.orangePrimary, size: 24),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textSecondary,
            ),
      ),
      onTap: onTap,
    );
  }
}
