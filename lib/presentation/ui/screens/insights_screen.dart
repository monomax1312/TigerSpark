import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../utils/error_message_mapper.dart';
import '../../bloc/insights/insights_bloc.dart';
import '../../bloc/insights/insights_event.dart';
import '../../bloc/insights/insights_state.dart';
import '../widgets/insight_card.dart';
import '../widgets/tiger_mascot.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InsightsBloc>().add(const InsightsLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsightsBloc, InsightsState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Column(
                    children: [
                      const TigerMascot(size: 70, showGlow: false),
                      const SizedBox(height: 8),
                      Text(
                        l10n.insightsTitle,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.insightsSubtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.insightsDescription,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (state is InsightsLoading)
              SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(color: AppTheme.orangePrimary),
                ),
              )
            else if (state is InsightsError)
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    ErrorMessageMapper(l10n).toUserMessage(state.message),
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              )
            else if (state is InsightsLoaded)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _ProgressCard(
                      totalCheckIns: state.totalCheckInCount,
                    ),
                    const SizedBox(height: 16),
                    ...state.insights
                        .map((i) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: InsightCard(insight: i),
                            )),
                    _LockedInsightCard(),
                  ]),
                ),
              )
            else
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        );
      },
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({required this.totalCheckIns});

  final int totalCheckIns;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final percent = (totalCheckIns / 15).clamp(0.0, 1.0) * 100;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.insightsProgressText(percent.toStringAsFixed(0)),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.orangePrimary,
                ),
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: percent / 100,
            backgroundColor: AppTheme.yellowClarity.withValues(alpha: 0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.orangePrimary),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.insightsProgressHint,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}

class _LockedInsightCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration().copyWith(
        color: AppTheme.textPrimary.withValues(alpha: 0.08),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.orangePrimary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.orangePrimary.withValues(alpha: 0.2),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Icon(Icons.lock_outline, color: AppTheme.orangePrimary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.insightsLockedTitle,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textSecondary,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.insightsLockedAfter('5'),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
