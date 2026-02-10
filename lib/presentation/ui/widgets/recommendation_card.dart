import 'package:flutter/material.dart';

import '../../../../domain/entities/recommendation.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../theme/app_theme.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({super.key, required this.recommendation});

  final Recommendation recommendation;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    IconData icon;
    Color tint;
    String title;
    String message;
    switch (recommendation.kind) {
      case RecommendationKind.workBest:
        icon = Icons.work_outline;
        tint = AppTheme.orangePrimary;
        title = recommendation.id == 'rec_default' ? l10n.recDefaultTitle : l10n.recWorkBestTitle;
        message = recommendation.id == 'rec_default' ? l10n.recDefaultMessage : l10n.recWorkBestMessage;
        break;
      case RecommendationKind.takePause:
        icon = Icons.pause_circle_outline;
        tint = AppTheme.yellowClarity;
        title = l10n.recPauseTitle;
        message = l10n.recPauseMessage;
        break;
      case RecommendationKind.avoidDecisions:
        icon = Icons.schedule;
        tint = AppTheme.textSecondary;
        title = l10n.recDecisionsTitle;
        message = l10n.recDecisionsMessage;
        break;
      case RecommendationKind.lightTasks:
        icon = Icons.lightbulb_outline;
        tint = AppTheme.yellowClarity;
        title = l10n.recLightTasksTitle;
        message = l10n.recLightTasksMessage;
        break;
    }
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration(withGlow: false).copyWith(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.orangePrimary.withValues(alpha: 0.06),
            AppTheme.white,
          ],
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: tint.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: tint.withValues(alpha: 0.25),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Icon(icon, color: tint, size: 24),
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
                const SizedBox(height: 4),
                Text(
                  message,
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
