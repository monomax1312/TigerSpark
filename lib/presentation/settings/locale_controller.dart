import 'package:flutter/material.dart';

class LocaleController extends ChangeNotifier {
  LocaleController() : _locale = null;

  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale? value) {
    if (_locale == value) return;
    _locale = value;
    notifyListeners();
  }
}
