import 'package:flutter/material.dart';

import '../../../../domain/entities/insight.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../theme/app_theme.dart';

class InsightCard extends StatelessWidget {
  const InsightCard({super.key, required this.insight});

  final Insight insight;

  static IconData _iconForType(InsightType type) {
    switch (type) {
      case InsightType.energyPeakTime:
        return Icons.bolt;
      case InsightType.bestTimeForHardTasks:
        return Icons.schedule;
      case InsightType.energyDropAfterMeetings:
        return Icons.groups;
      case InsightType.pauseRecommendation:
        return Icons.pause_circle_outline;
      case InsightType.decisionTimeWarning:
        return Icons.warning_amber_rounded;
      default:
        return Icons.auto_awesome;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final icon = _iconForType(insight.type);
    String title;
    String body;
    switch (insight.type) {
      case InsightType.energyPeakTime:
        title = l10n.insightEnergyPeakTitle;
        body = insight.formatParams != null
            ? l10n.insightEnergyPeakBody(
                insight.formatParams!['start']!,
                insight.formatParams!['end']!,
              )
            : insight.body;
        break;
      case InsightType.bestTimeForHardTasks:
        title = l10n.insightHardTasksTitle;
        body = l10n.insightHardTasksBody;
        break;
      case InsightType.custom:
        if (insight.priority == 0) {
          title = l10n.insightNeedDataTitle;
          body = l10n.insightNeedDataBody;
        } else if (insight.priority == 2) {
          title = l10n.insightTenseTitle;
          body = l10n.insightTenseBody;
        } else {
          title = insight.title;
          body = insight.body;
        }
        break;
      default:
        title = insight.title;
        body = insight.body;
    }
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration(withGlow: true),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.orangePrimary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
