import 'package:flutter/material.dart';

/// Lifts and scales its child while the pointer is over it.
///
/// Wrapping rather than restyling keeps the hover response identical across
/// cards, buttons and thumbnails without each one growing its own
/// [StatefulWidget] and controller.
class HoverLift extends StatefulWidget {
  final Widget child;

  /// Scale applied while hovered.
  final double scale;

  /// Logical pixels the child rises while hovered.
  final double lift;

  final Duration duration;
  final Curve curve;

  /// Shown under the child while hovered. Leave null for no shadow.
  final Color? shadowColor;
  final double shadowBlur;
  final BorderRadius? borderRadius;

  /// Set false to leave the child alone (e.g. a disabled control).
  final bool enabled;

  const HoverLift({
    super.key,
    required this.child,
    this.scale = 1.03,
    this.lift = 4,
    this.duration = const Duration(milliseconds: 220),
    this.curve = Curves.easeOut,
    this.shadowColor,
    this.shadowBlur = 20,
    this.borderRadius,
    this.enabled = true,
  });

  @override
  State<HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<HoverLift> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    final active = _hovered;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: widget.duration,
        curve: widget.curve,
        transform: Matrix4.identity()
          ..translateByDouble(0, active ? -widget.lift : 0, 0, 1)
          ..scaleByDouble(active ? widget.scale : 1, active ? widget.scale : 1,
              1, 1),
        transformAlignment: Alignment.center,
        decoration: widget.shadowColor == null
            ? null
            : BoxDecoration(
                borderRadius: widget.borderRadius,
                boxShadow: active
                    ? [
                        BoxShadow(
                          color: widget.shadowColor!,
                          blurRadius: widget.shadowBlur,
                          offset: const Offset(0, 8),
                        )
                      ]
                    : const [],
              ),
        child: widget.child,
      ),
    );
  }
}
