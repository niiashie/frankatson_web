import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frankoweb/ui/shared/animations/reveal.dart';

/// Opacity currently applied to the [Reveal] wrapping [key]'s widget.
double opacityOf(WidgetTester tester, Key key) {
  final opacity = tester.widget<Opacity>(
    find.ancestor(of: find.byKey(key), matching: find.byType(Opacity)).last,
  );
  return opacity.opacity;
}

Widget host(Widget child) => MaterialApp(home: Scaffold(body: child));

/// The pages all use [SingleChildScrollView], which builds its whole subtree —
/// so an off-screen [Reveal] really is mounted and really must stay hidden.
Widget scrollingHost(Widget child) => host(
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 2000),
            child,
            const SizedBox(height: 2000),
          ],
        ),
      ),
    );

void main() {
  const target = Key('target');
  const box = SizedBox(key: target, width: 50, height: 50);

  testWidgets('plays on mount when there is nothing to scroll', (tester) async {
    await tester.pumpWidget(host(const Reveal(child: box)));

    expect(opacityOf(tester, target), 0);
    await tester.pumpAndSettle();
    expect(opacityOf(tester, target), 1);
  });

  testWidgets('stays hidden below the fold, then plays once scrolled to',
      (tester) async {
    tester.view.physicalSize = const Size(800, 600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(scrollingHost(const Reveal(child: box)));
    await tester.pumpAndSettle();
    expect(opacityOf(tester, target), 0);

    await tester.drag(
        find.byType(SingleChildScrollView), const Offset(0, -1800));
    await tester.pumpAndSettle();
    expect(opacityOf(tester, target), 1);
  });

  testWidgets(
      'a widget inside a horizontal strip still reacts to the page scrolling '
      'vertically', (tester) async {
    tester.view.physicalSize = const Size(800, 600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(scrollingHost(
      const SizedBox(
        height: 100,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Reveal(child: box),
        ),
      ),
    ));
    await tester.pumpAndSettle();
    expect(opacityOf(tester, target), 0);

    // The nearest scrollable is the horizontal one, and it never moves. Only
    // the outer vertical scroll brings the widget into view, so Reveal has to
    // be listening to every scrollable above it, not just the closest.
    await tester.drag(
        find.byType(SingleChildScrollView).first, const Offset(0, -1800));
    await tester.pumpAndSettle();
    expect(opacityOf(tester, target), 1);
  });

  testWidgets('staggered siblings run in order', (tester) async {
    const keys = [Key('a'), Key('b'), Key('c')];

    await tester.pumpWidget(host(
      Column(
        children: List.generate(
          keys.length,
          (i) => Reveal.staggered(
            index: i,
            step: const Duration(milliseconds: 100),
            child: SizedBox(key: keys[i], width: 50, height: 50),
          ),
        ),
      ),
    ));

    // One frame to let the tickers start, then look partway through.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 150));

    expect(opacityOf(tester, keys[0]), greaterThan(0));
    expect(opacityOf(tester, keys[0]), greaterThan(opacityOf(tester, keys[1])));
    expect(opacityOf(tester, keys[2]), 0);

    await tester.pumpAndSettle();
    for (final key in keys) {
      expect(opacityOf(tester, key), 1);
    }
  });

  testWidgets('reduce-motion shows the content with no animation',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(disableAnimations: true),
        child: Scaffold(body: Reveal(child: box)),
      ),
    ));

    // No Opacity wrapper at all — the child is passed straight through.
    expect(
      find.ancestor(of: find.byKey(target), matching: find.byType(Opacity)),
      findsNothing,
    );
    expect(find.byKey(target), findsOneWidget);
  });
}
