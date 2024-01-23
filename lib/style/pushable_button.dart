import 'package:flutter/material.dart';

class PushableButton extends StatefulWidget {
  const PushableButton({
    super.key,
    this.child,
    required this.hslColor,
    required this.activeColor,
    required this.height,
    this.elevation = 6.0,
    this.shadow,
    this.onPressed,
  }) : assert(height > 0);

  final Widget? child;
  final HSLColor hslColor;
  final Color activeColor;
  final double height;
  final double elevation;
  final BoxShadow? shadow;
  final VoidCallback? onPressed;

  @override
  State<PushableButton> createState() => _PushableButtonState();
}

class _PushableButtonState extends State<PushableButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Color _topLayerColor = widget.hslColor.toColor();
  static const double _borderRadius = 16;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  void _handleTapDown(TapDownDetails details) {
    _topLayerColor = widget.activeColor;
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
    _topLayerColor = widget.hslColor.toColor();
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _topLayerColor = widget.hslColor.toColor();
      if (mounted) {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = widget.height + widget.elevation;
    return SizedBox(
      height: totalHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                final top = _animationController.value * widget.elevation;
                final hslColor = widget.hslColor;
                final bottomHslColor = hslColor.withLightness(hslColor.lightness - 0.08);
                return Stack(
                  children: [
                    // Draw bottom layer first
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: totalHeight - top,
                        decoration: BoxDecoration(
                          color: bottomHslColor.toColor(),
                          boxShadow: widget.shadow != null ? [widget.shadow!] : [],
                          borderRadius: BorderRadius.circular(_borderRadius),
                        ),
                      ),
                    ),
                    // Then top (pushable) layer
                    Positioned(
                      left: 0,
                      right: 0,
                      top: top,
                      child: Container(
                        height: widget.height,
                        decoration: ShapeDecoration(
                          color: _topLayerColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadius)),
                        ),
                        child: Center(child: widget.child),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
