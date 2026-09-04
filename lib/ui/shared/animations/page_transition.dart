import 'package:flutter/material.dart';

/// The app's standard page transition: the incoming page fades and eases up
/// into place while the outgoing one fades back, which reads better on the web
/// than the platform default (a full-width slide on iOS, a vertical jump on
/// Android).
class FadePageRoute<T> extends PageRouteBuilder<T> {
  FadePageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    this.direction = AxisDirection.up,
  }) : super(
          settings: settings,
          transitionDuration: const Duration(milliseconds: 420),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
        );

  /// Which way the incoming page travels as it settles.
  final AxisDirection direction;

  Offset get _begin {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, 0.035);
      case AxisDirection.down:
        return const Offset(0, -0.035);
      case AxisDirection.left:
        return const Offset(0.06, 0);
      case AxisDirection.right:
        return const Offset(-0.06, 0);
    }
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) return child;

    final entering = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    return FadeTransition(
      opacity: entering,
      child: SlideTransition(
        position: Tween<Offset>(begin: _begin, end: Offset.zero)
            .animate(entering),
        // The page being covered dims slightly so the new one reads as on top.
        child: FadeTransition(
          opacity: Tween<double>(begin: 1, end: 0.6).animate(
            CurvedAnimation(parent: secondaryAnimation, curve: Curves.easeOut),
          ),
          child: child,
        ),
      ),
    );
  }
}
