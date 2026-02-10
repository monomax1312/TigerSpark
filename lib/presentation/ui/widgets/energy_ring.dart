import 'dart:async';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class EnergyRing extends StatefulWidget {
  const EnergyRing({
    super.key,
    required this.level,
    this.size = 160,
    this.strokeWidth = 14,
    this.animate = true,
  });

  final int level;
  final double size;
  final double strokeWidth;
  final bool animate;

  @override
  State<EnergyRing> createState() => _EnergyRingState();
}

class _EnergyRingState extends State<EnergyRing> {
  double _pulse = 0;
  Timer? _pulseTimer;

  @override
  void initState() {
    super.initState();
    _schedulePulse();
  }

  void _schedulePulse() {
    if (!mounted) return;
    _pulseTimer = Timer(const Duration(milliseconds: 3400), () {
      if (!mounted) return;
      setState(() => _pulse = 1);
      _pulseTimer = Timer(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        setState(() => _pulse = 0);
        _schedulePulse();
      });
    });
  }

  @override
  void dispose() {
    _pulseTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = (widget.level.clamp(0, 5) / 5).toDouble();
    final glowIntensity = _glowForLevel(widget.level);
    final pulseBoost = _pulse * 0.15;
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _GlowRingPainter(
              progress: progress,
              strokeWidth: widget.strokeWidth,
              glowOpacity: glowIntensity + pulseBoost,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.orangePrimary.withValues(
                    alpha: (0.08 + glowIntensity * 0.35).clamp(0.0, 1.0),
                  ),
                  blurRadius: 20 + _pulse * 12,
                  spreadRadius: -2 + _pulse * 2,
                ),
              ],
            ),
            child: TweenAnimationBuilder<double>(
              key: ValueKey(widget.level),
              tween: Tween(begin: 0, end: progress),
              duration: widget.animate ? const Duration(milliseconds: 800) : Duration.zero,
              curve: Curves.easeOutCubic,
              builder: (context, value, _) => CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _ProgressRingPainter(
                  progress: value,
                  strokeWidth: widget.strokeWidth,
                ),
              ),
            ),
          ),
          Text(
            '${widget.level}',
            style: TextStyle(
              fontSize: widget.size * 0.35,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  /// 1–2 → почти нет, 3 → мягкий, 4–5 → заметный.
  double _glowForLevel(int level) {
    if (level <= 2) return 0.05;
    if (level == 3) return 0.18;
    return 0.35;
  }
}

class _ProgressRingPainter extends CustomPainter {
  _ProgressRingPainter({required this.progress, required this.strokeWidth});

  final double progress;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;
    final trackPaint = Paint()
      ..color = AppTheme.yellowClarity.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    final gradient = SweepGradient(
      startAngle: -1.57,
      endAngle: 4.71,
      colors: [AppTheme.orangePrimary, AppTheme.yellowClarity],
    );
    final rect = Rect.fromCircle(center: center, radius: radius);
    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.57,
      2 * 3.14159 * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter old) => old.progress != progress;
}

class _GlowRingPainter extends CustomPainter {
  _GlowRingPainter({
    required this.progress,
    required this.strokeWidth,
    this.glowOpacity = 0.25,
  });

  final double progress;
  final double strokeWidth;
  final double glowOpacity;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth / 2;
    final glowPaint = Paint()
      ..color = AppTheme.yellowClarity.withValues(alpha: glowOpacity.clamp(0.0, 1.0))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 8
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.57,
      2 * 3.14159 * progress,
      false,
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _GlowRingPainter old) =>
      old.progress != progress || old.glowOpacity != glowOpacity;
}
