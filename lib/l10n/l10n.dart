import 'package:flutter/material.dart';

class L10n {
  static final all = [Locale('en'), Locale('de')];

  static String getFlag(String code) {
    switch (code) {
      case 'de':
        return '🇩🇪';
      case 'en':
      default:
        return '🇺🇸';
    }
  }
}
