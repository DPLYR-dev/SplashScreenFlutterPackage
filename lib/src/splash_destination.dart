import 'package:flutter/widgets.dart';

/// Where a [SplashScreen] goes once it is done.
///
/// ```dart
/// SplashDestination.page(const HomePage())
/// SplashDestination.named('/home')
/// SplashDestination.route(MyCustomRoute())
/// SplashDestination.custom((context) => context.go('/home')) // go_router
/// ```
sealed class SplashDestination {
  const SplashDestination();

  /// Replace the splash with [page], using a fade transition.
  ///
  /// [name] and [arguments] become the route's [RouteSettings].
  const factory SplashDestination.page(
    Widget page, {
    String? name,
    Object? arguments,
  }) = PageDestination;

  /// Replace the splash with the named route [routeName].
  const factory SplashDestination.named(
    String routeName, {
    Object? arguments,
  }) = NamedDestination;

  /// Replace the splash with a custom [route] (e.g. a custom transition).
  const factory SplashDestination.route(Route<Object?> route) =
      RouteDestination;

  /// Run [navigate] yourself, e.g. for go_router or auto_route.
  const factory SplashDestination.custom(
    void Function(BuildContext context) navigate,
  ) = CustomDestination;
}

/// See [SplashDestination.page].
final class PageDestination extends SplashDestination {
  /// See [SplashDestination.page].
  const PageDestination(this.page, {this.name, this.arguments});

  /// Page shown after the splash.
  final Widget page;

  /// Route name stored in [RouteSettings.name].
  final String? name;

  /// Route arguments stored in [RouteSettings.arguments].
  final Object? arguments;
}

/// See [SplashDestination.named].
final class NamedDestination extends SplashDestination {
  /// See [SplashDestination.named].
  const NamedDestination(this.routeName, {this.arguments});

  /// Named route passed to [NavigatorState.pushReplacementNamed].
  final String routeName;

  /// Arguments passed to the named route.
  final Object? arguments;
}

/// See [SplashDestination.route].
final class RouteDestination extends SplashDestination {
  /// See [SplashDestination.route].
  const RouteDestination(this.route);

  /// Route passed to [NavigatorState.pushReplacement].
  final Route<Object?> route;
}

/// See [SplashDestination.custom].
final class CustomDestination extends SplashDestination {
  /// See [SplashDestination.custom].
  const CustomDestination(this.navigate);

  /// Callback that performs the navigation.
  final void Function(BuildContext context) navigate;
}
