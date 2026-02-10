import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../utils/error_message_mapper.dart';
import '../../utils/locale_helpers.dart';
import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_event.dart';
import '../../bloc/home/home_state.dart';
import '../widgets/energy_ring.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/tiger_mascot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const HomeLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return const _HomeView();
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        return RefreshIndicator(
          color: AppTheme.orangePrimary,
          onRefresh: () async {
            context.read<HomeBloc>().add(const HomeLoadRequested());
            await Future<void>.delayed(const Duration(milliseconds: 400));
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Column(
                    children: [
                      const TigerMascot(size: 100, showGlow: true),
                      const SizedBox(height: 8),
                      Text(
                        l10n.appTitle,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textPrimary,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.homeSubtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                      ),
                      const SizedBox(height: 20),
                      if (state is HomeLoading)
                        Padding(
                          padding: const EdgeInsets.all(32),
                          child: CircularProgressIndicator(color: AppTheme.orangePrimary),
                        )
                      else if (state is HomeLoaded) ...[
                        EnergyRing(
                          level: state.latestCheckIn?.energy.value ?? 0,
                          size: 180,
                          animate: true,
                        ),
                        if (state.latestCheckIn != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            _formatTime(context, state.latestCheckIn!.at),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${localizedMood(l10n, state.latestCheckIn!.mood)} · ${localizedFocus(l10n, state.latestCheckIn!.focus)}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                          ),
                        ] else
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Text(
                              l10n.homeCheckInPrompt,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.textSecondary,
                                  ),
                            ),
                          ),
                        if (state.contextDayTitleKey != null &&
                            state.contextDaySubtitleKey != null) ...[
                          const SizedBox(height: 20),
                          _ContextOfDayCard(
                            titleKey: state.contextDayTitleKey!,
                            subtitleKey: state.contextDaySubtitleKey!,
                            subtitleParam: state.contextDaySubtitleParam,
                          ),
                        ],
                      ] else if (state is HomeError)
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            ErrorMessageMapper(l10n).toUserMessage(state.message),
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      else
                        const EnergyRing(level: 0, size: 180, animate: false),
                    ],
                  ),
                ),
              ),
            ),
            if (state is HomeLoaded && state.recommendations.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                sliver: SliverToBoxAdapter(
                  child: RecommendationCard(recommendation: state.recommendations.first),
                ),
              ),
            if (state is HomeLoaded && state.microInsightKey != null)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                sliver: SliverToBoxAdapter(
                  child: _MicroInsightLine(keyName: state.microInsightKey!),
                ),
              )
            else if (state is HomeLoaded)
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        );
      },
    );
  }

  static String _formatTime(BuildContext context, DateTime at) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final atDay = DateTime(at.year, at.month, at.day);
    final timeStr = '${at.hour.toString().padLeft(2, '0')}:${at.minute.toString().padLeft(2, '0')}';
    if (atDay == today) {
      return l10n.todayAt(timeStr);
    }
    return l10n.dateShort(
      at.day.toString(),
      at.month.toString(),
      at.year.toString(),
    );
  }
}

class _ContextOfDayCard extends StatelessWidget {
  const _ContextOfDayCard({
    required this.titleKey,
    required this.subtitleKey,
    this.subtitleParam,
  });

  final String titleKey;
  final String subtitleKey;
  final String? subtitleParam;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final title = titleKey == 'homeContextToday' ? l10n.homeContextToday : l10n.homeContextPattern;
    final subtitle = subtitleKey == 'homeContextPatternDip'
        ? l10n.homeContextPatternDip
        : l10n.homeContextUsualEnergy(_levelParam(l10n, subtitleParam));
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: AppTheme.cardDecoration(withGlow: false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.orangePrimary,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
        ],
      ),
    );
  }

  String _levelParam(AppLocalizations l10n, String? param) {
    if (param == null) return l10n.energyLevelMedium;
    switch (param) {
      case 'high':
        return l10n.energyLevelHigh;
      case 'low':
        return l10n.energyLevelLow;
      default:
        return l10n.energyLevelMedium;
    }
  }
}

class _MicroInsightLine extends StatelessWidget {
  const _MicroInsightLine({required this.keyName});

  final String keyName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = keyName == 'homeMicroEveningFocus'
        ? l10n.homeMicroEveningFocus
        : keyName == 'homeMicroMorningPeak'
            ? l10n.homeMicroMorningPeak
            : l10n.homeMicroNotice;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.yellowClarity.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.yellowClarity.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('🐯', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
