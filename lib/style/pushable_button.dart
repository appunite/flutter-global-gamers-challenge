import 'package:flutter/material.dart';

class PushableButton extends StatefulWidget {
  const PushableButton({
    super.key,
    this.child,
    required this.hslColor,
    required this.activeColor,
    required this.height,
    this.width,
    this.elevation = 6.0,
    this.shadow,
    this.onPressed,
  }) : assert(height > 0);

  final Widget? child;
  final HSLColor hslColor;
  final Color activeColor;
  final double height;
  final double? width;
  final double elevation;
  final BoxShadow? shadow;
  final Function(Offset? offset)? onPressed;

  @override
  State<PushableButton> createState() => _PushableButtonState();
}

class _PushableButtonState extends State<PushableButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Color _topLayerColor = widget.hslColor.toColor();
  static const double _borderRadius = 16;
  late HSLColor bottomHslColor;

  @override
  void initState() {
    super.initState();
    bottomHslColor = widget.hslColor.withLightness(widget.hslColor.lightness - 0.08);
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
    widget.onPressed?.call(details.globalPosition);
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
      width: widget.width,
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

                return MouseRegion(
                  onHover: (event) {
                    setState(() {
                      _topLayerColor = widget.activeColor;
                      bottomHslColor = widget.hslColor.withLightness(hslColor.lightness - 0.1);
                    });
                  },
                  onExit: (event) {
                    setState(() {
                      _topLayerColor = widget.hslColor.toColor();
                      bottomHslColor = hslColor.withLightness(hslColor.lightness - 0.08);
                    });
                  },
                  child: Stack(
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
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
