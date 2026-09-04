import 'dart:async';

import 'package:flutter/material.dart';

/// The entrance effects available to [Reveal].
enum RevealEffect {
  /// Opacity only — no movement.
  fade,

  /// Rises into place from below.
  slideUp,

  /// Drops into place from above.
  slideDown,

  /// Travels in from the right, ending on the left of its start point.
  slideLeft,

  /// Travels in from the left, ending on the right of its start point.
  slideRight,

  /// Grows from slightly smaller than final size.
  zoomIn,

  /// Settles down from slightly larger than final size.
  zoomOut,
}

/// Plays an entrance animation the first time the widget scrolls into view.
///
/// The wrapper never changes the layout of [child] — the movement is done with
/// a [Transform], which paints off its final position rather than reserving
/// space for the travel. That means a section can be wrapped without the page
/// reflowing.
///
/// Visibility is resolved against the nearest [Scrollable]: the animation fires
/// once the widget's top edge crosses [threshold] of the viewport height. With
/// no scrollable ancestor (a static page) the animation simply plays on mount.
class Reveal extends StatefulWidget {
  final Widget child;

  /// Which entrance to play. Defaults to a rise-and-fade.
  final RevealEffect effect;

  /// How long the entrance takes.
  final Duration duration;

  /// Held before the entrance starts — the knob for staggering a group.
  final Duration delay;

  /// Distance travelled, in logical pixels, by the slide effects.
  final double distance;

  /// Starting scale for [RevealEffect.zoomIn] / [RevealEffect.zoomOut].
  final double scale;

  final Curve curve;

  /// Fraction of the viewport height the top edge must cross to trigger.
  /// Lower values wait until the widget is further up the screen.
  final double threshold;

  const Reveal({
    super.key,
    required this.child,
    this.effect = RevealEffect.slideUp,
    this.duration = const Duration(milliseconds: 650),
    this.delay = Duration.zero,
    this.distance = 40,
    this.scale = 0.92,
    this.curve = Curves.easeOutCubic,
    this.threshold = 0.9,
  });

  /// Convenience for staggering siblings: item [index] waits [step] longer
  /// than the one before it, up to [max] items' worth of delay. [baseDelay]
  /// holds the whole group back — useful when a heading animates in first.
  Reveal.staggered({
    super.key,
    required this.child,
    required int index,
    Duration step = const Duration(milliseconds: 90),
    Duration baseDelay = Duration.zero,
    int max = 8,
    this.effect = RevealEffect.slideUp,
    this.duration = const Duration(milliseconds: 650),
    this.distance = 40,
    this.scale = 0.92,
    this.curve = Curves.easeOutCubic,
    this.threshold = 0.9,
  }) : delay = Duration(
          milliseconds: baseDelay.inMilliseconds +
              (index < max ? index : max) * step.inMilliseconds,
        );

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: widget.curve,
  );

  /// Every scrollable between this widget and the root. A widget inside a
  /// horizontal strip needs the page's vertical position too, or scrolling
  /// down to it would never wake it up.
  final List<ScrollPosition> _positions = [];
  Timer? _delayTimer;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Nothing to scroll into — this is a static page, so just play.
      if (_positions.isEmpty) {
        _trigger();
      } else {
        _check();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_triggered) return;

    final found = <ScrollPosition>[];
    // A Scrollable's own context sits above the scope it provides, so looking
    // up from there walks out to the next scrollable rather than repeating it.
    for (BuildContext? ctx = context; ctx != null;) {
      final scrollable = Scrollable.maybeOf(ctx);
      if (scrollable == null) break;
      found.add(scrollable.position);
      ctx = scrollable.context;
    }

    if (_sameAsAttached(found)) return;

    _detach();
    _positions.addAll(found);
    for (final position in _positions) {
      position.addListener(_check);
    }
  }

  bool _sameAsAttached(List<ScrollPosition> found) {
    if (found.length != _positions.length) return false;
    for (var i = 0; i < found.length; i++) {
      if (!identical(found[i], _positions[i])) return false;
    }
    return true;
  }

  void _detach() {
    for (final position in _positions) {
      position.removeListener(_check);
    }
    _positions.clear();
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _detach();
    _controller.dispose();
    super.dispose();
  }

  void _check() {
    if (_triggered || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    final viewportHeight = MediaQuery.of(context).size.height;
    final top = box.localToGlobal(Offset.zero).dy;
    // Trigger once the top edge rises past the threshold line, but only while
    // some part of the widget is still below the top of the screen.
    if (top < viewportHeight * widget.threshold && top + box.size.height > 0) {
      _trigger();
    }
  }

  void _trigger() {
    if (_triggered) return;
    _triggered = true;
    _detach();

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      _delayTimer = Timer(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  Offset get _travel {
    switch (widget.effect) {
      case RevealEffect.slideUp:
        return Offset(0, widget.distance);
      case RevealEffect.slideDown:
        return Offset(0, -widget.distance);
      case RevealEffect.slideLeft:
        return Offset(widget.distance, 0);
      case RevealEffect.slideRight:
        return Offset(-widget.distance, 0);
      case RevealEffect.fade:
      case RevealEffect.zoomIn:
      case RevealEffect.zoomOut:
        return Offset.zero;
    }
  }

  double get _startScale {
    switch (widget.effect) {
      case RevealEffect.zoomIn:
        return widget.scale;
      case RevealEffect.zoomOut:
        return 2 - widget.scale;
      case RevealEffect.fade:
      case RevealEffect.slideUp:
      case RevealEffect.slideDown:
      case RevealEffect.slideLeft:
      case RevealEffect.slideRight:
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Honour the viewer's "reduce motion" setting — show the content outright.
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) {
      return widget.child;
    }

    final travel = _travel;
    final startScale = _startScale;

    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (context, child) {
        final t = _animation.value;
        final matrix = Matrix4.identity()
          ..translateByDouble(travel.dx * (1 - t), travel.dy * (1 - t), 0, 1);
        if (startScale != 1) {
          final scale = startScale + (1 - startScale) * t;
          matrix.scaleByDouble(scale, scale, 1, 1);
        }
        return Opacity(
          opacity: t,
          child: Transform(
            transform: matrix,
            alignment: Alignment.center,
            child: child,
          ),
        );
      },
    );
  }
}
