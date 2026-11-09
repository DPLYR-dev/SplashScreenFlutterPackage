import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:splashscreen/splashscreen.dart';

const _next = Scaffold(body: Text('next page'));

Widget _app(Widget home, {ThemeData? theme, NavigatorObserver? observer}) =>
    MaterialApp(
      theme: theme,
      home: home,
      navigatorObservers: [if (observer != null) observer],
      onGenerateRoute: (settings) => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => Scaffold(
          body: Text('named ${settings.name} ${settings.arguments}'),
        ),
      ),
    );

void main() {
  group('timer', () {
    testWidgets('navigates to page after duration', (tester) async {
      await tester.pumpWidget(_app(const SplashScreen.timer(
        duration: Duration(seconds: 2),
        destination: SplashDestination.page(_next),
        title: Text('splash'),
      )));

      expect(find.text('splash'), findsOneWidget);
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('next page'), findsNothing);

      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('next page'), findsOneWidget);
      expect(find.text('splash'), findsNothing);
    });

    testWidgets('page destination applies name and arguments', (tester) async {
      final observer = _RecordingObserver();
      await tester.pumpWidget(_app(
        const SplashScreen.timer(
          duration: Duration(seconds: 1),
          destination:
              SplashDestination.page(_next, name: '/home', arguments: 7),
        ),
        observer: observer,
      ));

      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(observer.replaced?.settings.name, '/home');
      expect(observer.replaced?.settings.arguments, 7);
    });

    testWidgets('named destination with arguments', (tester) async {
      await tester.pumpWidget(_app(const SplashScreen.timer(
        duration: Duration(seconds: 1),
        destination: SplashDestination.named('/next', arguments: 42),
      )));

      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('named /next 42'), findsOneWidget);
    });

    testWidgets('route destination', (tester) async {
      await tester.pumpWidget(_app(SplashScreen.timer(
        duration: const Duration(seconds: 1),
        destination: SplashDestination.route(MaterialPageRoute<void>(
          builder: (_) => const Scaffold(body: Text('custom route')),
        )),
      )));

      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('custom route'), findsOneWidget);
    });

    testWidgets('custom destination receives context', (tester) async {
      BuildContext? received;
      await tester.pumpWidget(_app(SplashScreen.timer(
        duration: const Duration(seconds: 1),
        destination: SplashDestination.custom((c) => received = c),
      )));

      await tester.pump(const Duration(seconds: 1));
      expect(received, isNotNull);
    });

    testWidgets('does not navigate after dispose', (tester) async {
      var called = false;
      await tester.pumpWidget(_app(SplashScreen.timer(
        duration: const Duration(seconds: 1),
        destination: SplashDestination.custom((_) => called = true),
      )));

      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 2));
      expect(called, isFalse);
      expect(tester.takeException(), isNull);
    });
  });

  group('future', () {
    testWidgets('navigates when future completes', (tester) async {
      final completer = Completer<SplashDestination>();
      await tester.pumpWidget(_app(SplashScreen.future(
        future: completer.future,
        title: const Text('splash'),
      )));

      await tester.pump(const Duration(seconds: 5));
      expect(find.text('splash'), findsOneWidget);

      completer.complete(const SplashDestination.page(_next));
      await tester.pumpAndSettle();
      expect(find.text('next page'), findsOneWidget);
    });

    testWidgets('waits at least minDuration', (tester) async {
      var called = false;
      await tester.pumpWidget(_app(SplashScreen.future(
        future: Future.value(
          SplashDestination.custom((_) => called = true),
        ),
        minDuration: const Duration(seconds: 2),
      )));

      await tester.pump(const Duration(seconds: 1));
      expect(called, isFalse);
      await tester.pump(const Duration(seconds: 1));
      expect(called, isTrue);
    });

    testWidgets('onError picks fallback destination', (tester) async {
      Object? seen;
      final completer = Completer<SplashDestination>();
      await tester.pumpWidget(_app(SplashScreen.future(
        future: completer.future,
        onError: (error, _) {
          seen = error;
          return const SplashDestination.page(_next);
        },
      )));

      completer.completeError(StateError('offline'));
      await tester.pumpAndSettle();
      expect(seen, isA<StateError>());
      expect(find.text('next page'), findsOneWidget);
    });

    testWidgets('error without onError is reported, splash stays',
        (tester) async {
      final completer = Completer<SplashDestination>();
      await tester.pumpWidget(_app(SplashScreen.future(
        future: completer.future,
        title: const Text('splash'),
      )));

      completer.completeError(StateError('offline'));
      await tester.pump();
      expect(tester.takeException(), isA<StateError>());
      expect(find.text('splash'), findsOneWidget);
    });

    testWidgets('completing after dispose does not throw', (tester) async {
      final completer = Completer<SplashDestination>();
      await tester.pumpWidget(_app(SplashScreen.future(
        future: completer.future,
      )));

      await tester.pumpWidget(const SizedBox());
      completer.complete(const SplashDestination.page(_next));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });
  });

  group('appearance', () {
    Widget splash({
      Color? backgroundColor,
      Widget? loader,
      bool showLoader = true,
      Object? heroTag = SplashScreen.defaultHeroTag,
      VoidCallback? onTap,
    }) =>
        SplashScreen.timer(
          duration: const Duration(seconds: 1),
          destination: const SplashDestination.page(_next),
          logo: const FlutterLogo(),
          title: const Text('title'),
          message: const Text('message'),
          backgroundColor: backgroundColor,
          loader: loader,
          showLoader: showLoader,
          heroTag: heroTag,
          onTap: onTap,
        );

    testWidgets('uses theme surface and primary by default', (tester) async {
      final theme = ThemeData(colorSchemeSeed: Colors.teal);
      await tester.pumpWidget(_app(splash(), theme: theme));

      final material = tester.widget<Material>(
        find
            .descendant(
              of: find.byType(SplashScreen),
              matching: find.byType(Material),
            )
            .first,
      );
      expect(material.color, theme.colorScheme.surface);
      final loader = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(loader.color, theme.colorScheme.primary);
      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('dark background gets light status bar and text',
        (tester) async {
      await tester.pumpWidget(_app(splash(backgroundColor: Colors.black)));

      final region = tester.widget<AnnotatedRegion<SystemUiOverlayStyle>>(
        find.byType(AnnotatedRegion<SystemUiOverlayStyle>).first,
      );
      expect(region.value, SystemUiOverlayStyle.light);
      final title = tester.widget<RichText>(
        find.descendant(
          of: find.text('title'),
          matching: find.byType(RichText),
        ),
      );
      expect(title.text.style?.color, Colors.white);
      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('custom loader replaces default', (tester) async {
      await tester.pumpWidget(_app(splash(loader: const Text('custom'))));
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('custom'), findsOneWidget);
      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('showLoader false hides loader', (tester) async {
      await tester.pumpWidget(_app(splash(showLoader: false)));
      expect(find.byType(CircularProgressIndicator), findsNothing);
      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('hero tag is configurable and can be disabled', (tester) async {
      await tester.pumpWidget(_app(splash()));
      expect(
        tester.widget<Hero>(find.byType(Hero)).tag,
        SplashScreen.defaultHeroTag,
      );

      await tester.pumpWidget(_app(splash(heroTag: null)));
      expect(find.byType(Hero), findsNothing);
      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('onTap fires', (tester) async {
      var taps = 0;
      await tester.pumpWidget(_app(splash(onTap: () => taps++)));
      await tester.tap(find.byType(SplashScreen));
      expect(taps, 1);
      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('entrance animation is skipped with reduced motion',
        (tester) async {
      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: _app(splash()),
      ));
      expect(
        find.descendant(
          of: find.byType(SafeArea),
          matching: find.byType(FadeTransition),
        ),
        findsNothing,
      );
      await tester.pump(const Duration(seconds: 1));
    });
  });
}

class _RecordingObserver extends NavigatorObserver {
  Route<dynamic>? replaced;

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    replaced = newRoute;
  }
}
