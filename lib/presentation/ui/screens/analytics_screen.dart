import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/energy_summary.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../utils/error_message_mapper.dart';
import '../../bloc/analytics/analytics_bloc.dart';
import '../../bloc/analytics/analytics_event.dart';
import '../../bloc/analytics/analytics_state.dart';
import '../widgets/tiger_mascot.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AnalyticsBloc>().add(const AnalyticsLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsBloc, AnalyticsState>(
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
                        l10n.analyticsTitle,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.analyticsSubtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (state is AnalyticsLoading)
              SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(color: AppTheme.orangePrimary),
                ),
              )
            else if (state is AnalyticsError)
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    ErrorMessageMapper(l10n).toUserMessage(state.message),
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              )
            else if (state is AnalyticsLoaded) ...[
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                sliver: SliverToBoxAdapter(
                  child: _SummaryLine(summaryKey: state.summaryKey),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                sliver: SliverToBoxAdapter(
                  child: _EnergyChart(summaries: state.summaries),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final s = state.summaries[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _DayTile(summary: s),
                      );
                    },
                    childCount: state.summaries.length,
                  ),
                ),
              ),
            ]
            else
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        );
      },
    );
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({this.summaryKey});

  final String? summaryKey;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String text;
    switch (summaryKey) {
      case 'rise':
        text = l10n.analyticsSummaryRise;
        break;
      case 'fewData':
        text = l10n.analyticsSummaryFewData;
        break;
      case 'fluctuations':
        text = l10n.analyticsSummaryFluctuations;
        break;
      default:
        text = l10n.analyticsSummaryFewData;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppTheme.orangePrimary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.orangePrimary.withValues(alpha: 0.07),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Icon(
              summaryKey == 'fewData' ? Icons.info_outline : Icons.trending_up,
              size: 18,
              color: AppTheme.orangePrimary,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppTheme.orangePrimary,
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _EnergyChart extends StatelessWidget {
  const _EnergyChart({required this.summaries});

  final List<EnergySummary> summaries;

  @override
  Widget build(BuildContext context) {
    final spots = <FlSpot>[];
    for (var i = 0; i < summaries.length; i++) {
      final s = summaries[i];
      spots.add(FlSpot(i.toDouble(), s.averageEnergy));
    }
    if (spots.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      return Container(
        height: 180,
        alignment: Alignment.center,
        decoration: AppTheme.cardDecoration(),
        child: Text(
          l10n.analyticsEmpty,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
          textAlign: TextAlign.center,
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(16),
      height: 200,
      decoration: AppTheme.cardDecoration(withGlow: true),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true, drawVerticalLine: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                getTitlesWidget: (value, meta) => Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 24,
                getTitlesWidget: (value, meta) {
                  final idx = value.toInt();
                  if (idx >= 0 && idx < summaries.length) {
                    final d = summaries[idx].date;
                    return Text(
                      '${d.day}.${d.month}',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: (summaries.length - 1).toDouble(),
          minY: 0,
          maxY: 5.5,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: AppTheme.orangePrimary,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: AppTheme.orangePrimary.withValues(alpha: 0.15),
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}

class _DayTile extends StatelessWidget {
  const _DayTile({required this.summary});

  final EnergySummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dateStr = DateFormat('dd.MM').format(summary.date);
    final avg = summary.averageEnergy.toStringAsFixed(1);
    final count = summary.checkInCount;
    String fluctuationText;
    switch (summary.fluctuationLevel) {
      case 'high':
        fluctuationText = l10n.analyticsDayFluctuationHigh;
        break;
      case 'medium':
        fluctuationText = l10n.analyticsDayFluctuationMedium;
        break;
      case 'low':
        fluctuationText = l10n.analyticsDayFluctuationLow;
        break;
      default:
        fluctuationText = l10n.analyticsDayFluctuationLow;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                dateStr,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${l10n.analyticsAverage}: $avg',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.orangePrimary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Text(
            fluctuationText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
          Text(
            '${l10n.analyticsDayCheckIns}: $count',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}
