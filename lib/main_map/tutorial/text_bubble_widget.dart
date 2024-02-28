import 'package:better_world/main_map/tutorial/eco_text_bubble_type.dart';
import 'package:better_world/style/const_values.dart';
import 'package:better_world/style/palette.dart';
import 'package:flutter/material.dart';

class TextBubbleWidget extends StatelessWidget {
  const TextBubbleWidget({super.key, required this.textBubbleType});

  final EcoTextBubbleType textBubbleType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        tail(),
        Container(
          constraints: const BoxConstraints(maxWidth: 350),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Palette.neutralWhite,
            borderRadius: borderRadius32,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF212121).withOpacity(.2),
                offset: const Offset(2, 6),
              ),
            ],
          ),
          child: Text(
            textBubbleType.text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget tail() => SizedBox(
        height: 25,
        width: 15,
        child: CustomPaint(
          painter: _TrianglePainter(),
        ),
      );
}

class _TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    final paint = Paint()
      ..color = Palette.neutralWhite
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, height / 2 - 3)
      ..arcToPoint(
        Offset(0, height / 2 + 3),
        radius: const Radius.circular(4),
        clockwise: false,
      )
      ..lineTo(width, height)
      ..lineTo(width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
