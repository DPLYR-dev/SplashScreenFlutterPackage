import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'splash_animation.dart';
import 'splash_destination.dart';

/// Signature for [SplashScreen.future]'s `onError`: map a failure of the
/// future to a fallback destination.
typedef SplashErrorHandler = SplashDestination Function(
  Object error,
  StackTrace stackTrace,
);

/// A splash screen showing an optional logo, title, loader and message, then
/// replacing itself with a [SplashDestination].
///
/// Colors default to the ambient [Theme], so light and dark mode work out of
/// the box.
class SplashScreen extends StatefulWidget {
  /// Shows the splash for [duration], then navigates to [destination].
  const SplashScreen.timer({
    super.key,
    required Duration this.duration,
    required SplashDestination this.destination,
    this.logo,
    this.logoSize = 120,
    this.heroTag = defaultHeroTag,
    this.title,
    this.message,
    this.showLoader = true,
    this.loader,
    this.loaderColor,
    this.backgroundColor,
    this.foregroundColor,
    this.backgroundGradient,
    this.backgroundImage,
    this.animation = SplashAnimation.fadeScale,
    this.animationDuration = const Duration(milliseconds: 700),
    this.animationCurve = Curves.easeOutCubic,
    this.transitionDuration = const Duration(milliseconds: 400),
    this.systemOverlayStyle,
    this.onTap,
  })  : future = null,
        minDuration = Duration.zero,
        onError = null;

  /// Shows the splash until [future] completes, then navigates to the
  /// destination it resolves to.
  ///
  /// The splash stays up for at least [minDuration] to avoid a jarring
  /// flash when the future completes instantly. If the future fails,
  /// [onError] picks a fallback destination; without it the error is
  /// reported to [FlutterError.onError] and the splash stays on screen.
  const SplashScreen.future({
    super.key,
    required Future<SplashDestination> this.future,
    this.minDuration = Duration.zero,
    this.onError,
    this.logo,
    this.logoSize = 120,
    this.heroTag = defaultHeroTag,
    this.title,
    this.message,
    this.showLoader = true,
    this.loader,
    this.loaderColor,
    this.backgroundColor,
    this.foregroundColor,
    this.backgroundGradient,
    this.backgroundImage,
    this.animation = SplashAnimation.fadeScale,
    this.animationDuration = const Duration(milliseconds: 700),
    this.animationCurve = Curves.easeOutCubic,
    this.transitionDuration = const Duration(milliseconds: 400),
    this.systemOverlayStyle,
    this.onTap,
  })  : duration = null,
        destination = null;

  /// Default [heroTag] wrapped around [logo].
  static const String defaultHeroTag = 'splashscreenImage';

  /// How long a [SplashScreen.timer] stays on screen.
  final Duration? duration;

  /// Where a [SplashScreen.timer] navigates to.
  final SplashDestination? destination;

  /// Future a [SplashScreen.future] waits for.
  final Future<SplashDestination>? future;

  /// Minimum time a [SplashScreen.future] stays on screen.
  final Duration minDuration;

  /// Fallback for a failed [future].
  final SplashErrorHandler? onError;

  /// Logo or illustration shown in the center, e.g. an [Image] or [Icon].
  final Widget? logo;

  /// Width and height of the box the [logo] is laid out in.
  final double logoSize;

  /// [Hero] tag for the [logo]; use the same tag on the destination page to
  /// animate the logo across. `null` disables the hero.
  final Object? heroTag;

  /// Shown under the logo. A plain [Text] picks up a themed headline style.
  final Widget? title;

  /// Shown under the loader, e.g. `Text('Loading…')`.
  final Widget? message;

  /// Whether to show the [loader].
  final bool showLoader;

  /// Custom loading indicator. Defaults to a themed
  /// [CircularProgressIndicator].
  final Widget? loader;

  /// Color of the default loader. Defaults to [ColorScheme.primary].
  final Color? loaderColor;

  /// Background color. Defaults to [ColorScheme.surface].
  final Color? backgroundColor;

  /// Text color for [title] and [message]. Defaults to [ColorScheme.onSurface]
  /// or, when [backgroundColor] is set, a color that contrasts with it.
  final Color? foregroundColor;

  /// Background gradient, painted over [backgroundColor].
  final Gradient? backgroundGradient;

  /// Background image, painted over [backgroundColor].
  final DecorationImage? backgroundImage;

  /// Entrance animation for the content.
  final SplashAnimation animation;

  /// Length of the entrance [animation].
  final Duration animationDuration;

  /// Curve of the entrance [animation].
  final Curve animationCurve;

  /// Fade duration when navigating to a [SplashDestination.page].
  final Duration transitionDuration;

  /// Status/navigation bar style. Defaults to one that contrasts with the
  /// background.
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// Called when the user taps anywhere on the splash.
  final VoidCallback? onTap;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.animationDuration,
  );
  late final Animation<double> _curved = CurvedAnimation(
    parent: _controller,
    curve: widget.animationCurve,
  );
  Timer? _timer;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    unawaited(_controller.forward());
    final future = widget.future;
    if (future == null) {
      _timer = Timer(widget.duration!, () => _go(widget.destination!));
    } else {
      unawaited(_waitFor(future));
    }
  }

  Future<void> _waitFor(Future<SplashDestination> future) async {
    final minElapsed = Completer<void>();
    _timer = Timer(widget.minDuration, minElapsed.complete);

    SplashDestination destination;
    try {
      destination = await future;
    } catch (error, stackTrace) {
      final onError = widget.onError;
      if (onError == null) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'splashscreen',
          context: ErrorDescription('while waiting for SplashScreen.future'),
        ));
        return;
      }
      destination = onError(error, stackTrace);
    }
    await minElapsed.future;
    _go(destination);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _go(SplashDestination destination) {
    // The splash may already be gone (e.g. the user navigated away).
    if (!mounted || _navigated) return;
    _navigated = true;
    switch (destination) {
      case PageDestination(:final page, :final name, :final arguments):
        Navigator.of(context).pushReplacement(PageRouteBuilder<void>(
          settings: RouteSettings(name: name, arguments: arguments),
          transitionDuration: widget.transitionDuration,
          reverseTransitionDuration: widget.transitionDuration,
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
            child: child,
          ),
        ));
      case NamedDestination(:final routeName, :final arguments):
        Navigator.of(context)
            .pushReplacementNamed(routeName, arguments: arguments);
      case RouteDestination(:final route):
        Navigator.of(context).pushReplacement(route);
      case CustomDestination(:final navigate):
        navigate(context);
    }
  }

  Widget _animate(Widget child) {
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (reduceMotion) return child;
    final scale = Tween<double>(begin: 0.88, end: 1).animate(_curved);
    final slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(_curved);
    return switch (widget.animation) {
      SplashAnimation.none => child,
      SplashAnimation.fade => FadeTransition(opacity: _curved, child: child),
      SplashAnimation.scale => ScaleTransition(scale: scale, child: child),
      SplashAnimation.fadeScale => FadeTransition(
          opacity: _curved,
          child: ScaleTransition(scale: scale, child: child),
        ),
      SplashAnimation.slideUp => FadeTransition(
          opacity: _curved,
          child: SlideTransition(position: slide, child: child),
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final background = widget.backgroundColor ?? scheme.surface;
    final isDark =
        ThemeData.estimateBrightnessForColor(background) == Brightness.dark;
    final foreground = widget.foregroundColor ??
        (widget.backgroundColor == null
            ? scheme.onSurface
            : (isDark ? Colors.white : Colors.black87));

    final logo = widget.logo;
    final title = widget.title;
    final message = widget.message;

    final hero = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (logo != null)
          SizedBox.square(
            dimension: widget.logoSize,
            child: widget.heroTag == null
                ? logo
                : Hero(tag: widget.heroTag!, child: logo),
          ),
        if (logo != null && title != null) const SizedBox(height: 24),
        if (title != null)
          DefaultTextStyle.merge(
            style: theme.textTheme.headlineSmall?.copyWith(
              color: foreground,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            child: title,
          ),
      ],
    );

    final footer = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showLoader)
          widget.loader ??
              SizedBox.square(
                dimension: 32,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: widget.loaderColor ?? scheme.primary,
                  semanticsLabel: 'Loading',
                ),
              ),
        if (widget.showLoader && message != null) const SizedBox(height: 16),
        if (message != null)
          DefaultTextStyle.merge(
            style: theme.textTheme.bodyMedium?.copyWith(
              color: foreground.withAlpha(0xB3),
            ),
            textAlign: TextAlign.center,
            child: message,
          ),
      ],
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: widget.systemOverlayStyle ??
          (isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark),
      child: Material(
        color: background,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: widget.backgroundGradient,
              image: widget.backgroundImage,
            ),
            child: SafeArea(
              child: _animate(
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(flex: 2, child: Center(child: hero)),
                      Expanded(child: Center(child: footer)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
