import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sneakers_shop/app/app_preferences.dart';
import 'package:sneakers_shop/presentation/resources/language_manager.dart';

class ThemeMangerViewModel extends ThemeMangerInput with ThemeManagerOutput {
  final StreamController _streamController = BehaviorSubject<bool>();
  final StreamController _localStreamController = BehaviorSubject<Locale>();

  bool _isDark = false;
  late Locale _locale;
  final AppPreferences _appPreferences;
  ThemeMangerViewModel(this._appPreferences);
  @override
  Sink get isDark => _streamController.sink;

  @override
  Stream<bool> get isDarkOutput =>
      _streamController.stream.map((event) => event);
  @override
  changeTheme() async {
    _isDark = !_isDark;
    await _appPreferences.setIsDark(_isDark);
    isDark.add(_isDark);
  }

  @override
  dispose() {
    _streamController.close();
    _localStreamController.close();
  }

  @override
  init() {
    _getCurrentTheme();
    _getCurrentLanguage();
  }

  @override
  changeLanguage(String value) async{
    _locale = LanguageType.english.getLocaleFromSharedPref(value);
   await _appPreferences.setAppLanguage(value);
    inputLocal.add(_locale);
  }

  _getCurrentTheme() {
    bool? currentIsDark = _appPreferences.getIsDark();

    _isDark = currentIsDark ?? ThemeMode.system == ThemeMode.dark;
    isDark.add(_isDark);
  }

  _getCurrentLanguage() {
    _locale = _appPreferences.getAppLocale();
    inputLocal.add(_locale);
  }

  @override
  Sink get inputLocal => _localStreamController.sink;

  @override
  Stream<Locale> get outputLocal =>
      _localStreamController.stream.map((local) => local);
}

abstract class ThemeMangerInput {
  Sink get isDark;
  Sink get inputLocal;
  changeTheme();
  init();
  dispose();
  changeLanguage(String value);
}

abstract class ThemeManagerOutput {
  Stream<bool> get isDarkOutput;
  Stream<Locale> get outputLocal;
}
