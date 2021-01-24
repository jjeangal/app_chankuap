///To use this font, place it in your fonts/ directory and include the
/// following in your pubspec.yaml
///
/// flutter:
///   fonts:
///    - family:  MyFlutterApp
///      fonts:
///       - asset: fonts/AppIcons.ttf
///
///
///
import 'package:flutter/widgets.dart';

class AppIcons {
  AppIcons._();

  static const _kFontFam = 'AppIcons';
  static const _kFontPkg = null;

  static const IconData storage =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData transaction =
      IconData(0xe805, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData entry =
      IconData(0xe806, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
