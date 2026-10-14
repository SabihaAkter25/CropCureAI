import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CropCureLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final bool isDarkBackground;

  const CropCureLogo({
    super.key,
    this.size = 100,
    this.showText = false,
    this.isDarkBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.forestGreen.withValues(alpha: 0.25),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: CustomPaint(
            size: Size(size, size),
            painter: _LogoPainter(),
          ),
        ),
        if (showText) ...[
          const SizedBox(height: 12),
          Text(
            'CropCure AI',
            style: TextStyle(
              fontSize: size * 0.28,
              fontWeight: FontWeight.w800,
              color: isDarkBackground ? Colors.white : AppColors.forestGreen,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.goldenGrain,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Healthy Crops, Better Harvests',
                style: TextStyle(
                  fontSize: size * 0.12,
                  fontWeight: FontWeight.w600,
                  color: isDarkBackground
                      ? AppColors.lightGreenBg
                      : AppColors.textMuted,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.goldenGrain,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ]
      ],
    );
  }
}

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Outer Circle Gradient (Forest Green to Leaf Green)
    const bgGradient = RadialGradient(
      center: Alignment.topLeft,
      radius: 1.2,
      colors: [
        AppColors.forestGreen,
        AppColors.darkForest,
      ],
    );

    final bgPaint = Paint()
      ..shader = bgGradient.createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, bgPaint);

    // Inner Golden Rim
    final rimPaint = Paint()
      ..color = AppColors.goldenGrain.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.03;
    canvas.drawCircle(center, radius * 0.9, rimPaint);

    // Rice Stalk Path
    final stalkPath = Path();
    stalkPath.moveTo(size.width * 0.5, size.height * 0.82);
    stalkPath.cubicTo(
      size.width * 0.5, size.height * 0.6,
      size.width * 0.45, size.height * 0.4,
      size.width * 0.55, size.height * 0.22,
    );

    final stalkPaint = Paint()
      ..color = AppColors.goldenGrain
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width * 0.045;
    canvas.drawPath(stalkPath, stalkPaint);

    // Rice Grains (Golden paddy ears)
    final grainPaint = Paint()
      ..color = AppColors.goldenGrain
      ..style = PaintingStyle.fill;

    final grainPositions = [
      Offset(size.width * 0.53, size.height * 0.24),
      Offset(size.width * 0.44, size.height * 0.30),
      Offset(size.width * 0.57, size.height * 0.35),
      Offset(size.width * 0.42, size.height * 0.42),
      Offset(size.width * 0.56, size.height * 0.48),
    ];

    for (var pos in grainPositions) {
      canvas.drawOval(
        Rect.fromCenter(center: pos, width: size.width * 0.09, height: size.height * 0.16),
        grainPaint,
      );
    }

    // Lush Green Rice Leaf
    final leafPath = Path();
    leafPath.moveTo(size.width * 0.28, size.height * 0.78);
    leafPath.quadraticBezierTo(
      size.width * 0.12, size.height * 0.45,
      size.width * 0.42, size.height * 0.30,
    );
    leafPath.quadraticBezierTo(
      size.width * 0.35, size.height * 0.58,
      size.width * 0.48, size.height * 0.76,
    );
    leafPath.close();

    const leafGradient = LinearGradient(
      colors: [AppColors.accentGreen, AppColors.brightGreen],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    );

    final leafPaint = Paint()
      ..shader = leafGradient.createShader(leafPath.getBounds());
    canvas.drawPath(leafPath, leafPaint);

    // AI Circuit Nodes & Subtle Glowing Connections
    final aiPaint = Paint()
      ..color = AppColors.mintGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.02;

    final nodePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // AI Nodes
    final node1 = Offset(size.width * 0.68, size.height * 0.35);
    final node2 = Offset(size.width * 0.75, size.height * 0.52);
    final node3 = Offset(size.width * 0.62, size.height * 0.65);

    final aiPath = Path();
    aiPath.moveTo(size.width * 0.52, size.height * 0.40);
    aiPath.lineTo(node1.dx, node1.dy);
    aiPath.lineTo(node2.dx, node2.dy);
    aiPath.lineTo(node3.dx, node3.dy);
    aiPath.lineTo(size.width * 0.48, size.height * 0.72);

    canvas.drawPath(aiPath, aiPaint);

    canvas.drawCircle(node1, size.width * 0.035, nodePaint);
    canvas.drawCircle(node2, size.width * 0.035, nodePaint);
    canvas.drawCircle(node3, size.width * 0.035, nodePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
