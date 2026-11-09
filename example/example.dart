import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
      ),
      home: SplashScreen.future(
        future: _bootstrap(),
        minDuration: const Duration(seconds: 2),
        onError: (error, stackTrace) =>
            const SplashDestination.page(HomePage(message: 'Offline mode')),
        logo: const FlutterLogo(),
        title: const Text('Welcome to SplashScreen'),
        message: const Text('Getting things ready…'),
        animation: SplashAnimation.fadeScale,
      ),
    );
  }
}

/// Load whatever the app needs (auth, config, …) and decide where to go.
Future<SplashDestination> _bootstrap() async {
  await Future<void>.delayed(const Duration(seconds: 1));
  return const SplashDestination.page(HomePage(message: 'Succeeded!'));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SplashScreen example')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Same tag as the splash logo -> animated across with a Hero.
            const Hero(
              tag: SplashScreen.defaultHeroTag,
              child: FlutterLogo(size: 64),
            ),
            const SizedBox(height: 16),
            Text(message, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}
