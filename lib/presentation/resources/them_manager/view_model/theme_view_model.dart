import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sneakers_shop/app/app_preferences.dart';

class ThemeMangerViewModel extends ThemeMangerInput with ThemeManagerOutput {
  final StreamController _streamController = BehaviorSubject<bool>();
  bool _isDark = false;
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
  }

  @override
  init() {
    bool? currentIsDark = _appPreferences.getIsDark();

    _isDark = currentIsDark ?? ThemeMode.system == ThemeMode.dark;
    isDark.add(_isDark);
  }
}

abstract class ThemeMangerInput {
  Sink get isDark;
  changeTheme();
  init();
  dispose();
}

abstract class ThemeManagerOutput {
  Stream<bool> get isDarkOutput;
}
