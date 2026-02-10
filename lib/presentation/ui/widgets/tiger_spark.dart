import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class TigerSparkOverlay extends StatefulWidget {
  const TigerSparkOverlay({
    super.key,
    this.duration = const Duration(milliseconds: 400),
    this.onComplete,
  });

  final Duration duration;
  final VoidCallback? onComplete;

  @override
  State<TigerSparkOverlay> createState() => _TigerSparkOverlayState();
}

class _TigerSparkOverlayState extends State<TigerSparkOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _scale = Tween<double>(begin: 0.3, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _opacity = Tween<double>(begin: 0.9, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1, curve: Curves.easeOut)),
    );
    _controller.forward().then((_) {
      widget.onComplete?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return IgnorePointer(
          child: SizedBox.expand(
            child: CustomPaint(
              painter: _TigerSparkPainter(
                progress: _controller.value,
                scale: _scale.value,
                opacity: _opacity.value,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TigerSparkPainter extends CustomPainter {
  _TigerSparkPainter({
    required this.progress,
    required this.scale,
    required this.opacity,
  });

  final double progress;
  final double scale;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = 24.0 * scale;
    final glowPaint = Paint()
      ..color = AppTheme.goldSpark.withValues(alpha: opacity * 0.35)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, baseRadius * 1.5);
    canvas.drawCircle(center, baseRadius * 2, glowPaint);
    final ringPaint = Paint()
      ..color = AppTheme.goldSpark.withValues(alpha: opacity * 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, baseRadius, ringPaint);
  }

  @override
  bool shouldRepaint(covariant _TigerSparkPainter old) =>
      old.progress != progress || old.scale != scale || old.opacity != opacity;
}
