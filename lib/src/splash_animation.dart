/// Entrance animation played by the splash content when it first appears.
///
/// Skipped automatically when the platform requests reduced motion.
enum SplashAnimation {
  /// No animation.
  none,

  /// Fade in.
  fade,

  /// Grow from slightly smaller.
  scale,

  /// Fade in while growing (default).
  fadeScale,

  /// Fade in while sliding up.
  slideUp,
}
