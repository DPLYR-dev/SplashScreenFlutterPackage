# Changelog

## [3.0.0] - Redesign

**Breaking** — see "Migrating from 2.x" in the README.

* New type-safe `SplashDestination`: `.page`, `.named` (with arguments), `.route`, `.custom` (go_router, auto_route…)
* `SplashScreen.timer` takes a `Duration`; `SplashScreen.future` takes a `Future<SplashDestination>`
* `SplashScreen.future` gains `minDuration` and `onError`; errors are reported instead of silently unhandled
* Material 3 / dark-mode aware defaults from the ambient `Theme`
* Entrance animations via `SplashAnimation` (respects reduced motion)
* Fade transition into `SplashDestination.page`, configurable `transitionDuration`
* Any widget for `logo`, `title`, `message` and `loader`
* `backgroundGradient`, `backgroundImage` (`DecorationImage`), `foregroundColor`, automatic status bar contrast
* Configurable / disableable `heroTag`
* Content wrapped in `SafeArea`; constructors are now `const`
* Sources split under `lib/src/`
* New light / dark / gradient screenshots

## [2.1.0] - Modernization

* Fix: cancel the timer on dispose and skip navigation if the splash is no longer mounted (prevented "Looking up a deactivated widget's ancestor" errors)
* Add `key` parameter to `SplashScreen.timer` / `SplashScreen.future`
* Add `SplashScreen.heroTag` constant for the image `Hero` tag
* `pageRoute` is now typed `Route<Object?>?`; `navigateAfterSeconds` on `SplashScreen.future` is `Object?` instead of `dynamic`
* Use `CircularProgressIndicator.color` instead of `valueColor`
* Add widget tests, `flutter_lints`, and GitHub Actions CI
* Add pub.dev metadata (repository, issue tracker, topics, screenshots)
* Refresh README examples (no `new`, const constructors, correct links)
* Stop tracking IDE files and `pubspec.lock`

## [2.0.0] - Dart 3 Support

* Updated SDK constraint to Dart 3 (>=3.0.0 <4.0.0)
* Added Flutter SDK constraint (>=3.10.0)
* Replaced deprecated Container and Padding patterns with SizedBox
* Updated example with const constructors and super.key parameters
* Code cleanup and modernization

## [1.4.0] - Null Safety Support

* Implement null safety support

## [1.3.4] - Fix Route Name

* Fix routeName issue

## [1.3.3] - Edit README.md

* Add DPLYR Credits to README.md

## [1.3.2] - Raise pubscore

* Change pubspec description and format files

## [1.3.1] - Edit README.md

* Add similar packages

## [1.3.0] - Reopening the package

* Add More Features

## [0.0.9] - Edit Readme.md

* Editing

## [0.0.8] - Change Some Things

* Change Image Network To Image Widget

## [0.0.7] - Add A ScreenShot in README.md

* Only Edit in README.md

## [0.0.6] - Fix Some Issues & Final Release

* Fix Some Issues

## [0.0.5] - Loader Color

* Add Color Feature To Loader (CircularProgressIndicator)

## [0.0.4] - Release Preview

* Add onClick And Fix Some Errors

## [0.0.3] - Beta 2

* Add Some Features (photoRadius)

## [0.0.2] - Fix Issues

* Fix Big Issues , Infinite Navigation

## [0.0.1] - Beta 1

* SplashScreen Library First Release
