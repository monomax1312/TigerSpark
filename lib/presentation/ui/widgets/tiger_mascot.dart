import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class TigerMascot extends StatelessWidget {
  const TigerMascot({
    super.key,
    this.size = 120,
    this.showGlow = true,
  });

  final double size;
  final bool showGlow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (showGlow)
            Container(
              width: size * 1.2,
              height: size * 1.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.yellowClarity.withValues(alpha: 0.12),
                    AppTheme.orangePrimary.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ClipRRect(
            borderRadius: BorderRadius.circular(size / 2),
            child: Image.asset(
              'assets/images/tiger_mascot.png',
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _PlaceholderMascot(size: size),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderMascot extends StatelessWidget {
  const _PlaceholderMascot({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppTheme.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppTheme.orangePrimary.withValues(alpha: 0.4),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Icon(Icons.bolt, size: size * 0.5, color: Colors.white),
    );
  }
}
