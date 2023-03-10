import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:sneakers_shop/presentation/resources/language_manager.dart";

import "app_constant.dart";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);
  String getAppLanguage() {
    return _sharedPreferences.getString(AppConstants.languageKey) ??
        LanguageType.english.getLanguage();
  }

  Future<bool> setAppLanguage(String value) async {
    return await _sharedPreferences.setString(AppConstants.languageKey, value);
  }

  bool? getIsDark() {
    return _sharedPreferences.getBool(AppConstants.darkKey);
  }

  Future<bool> setIsDark(bool value) async {
    return await _sharedPreferences.setBool(AppConstants.darkKey, value);
  }

  String getPaymentToken() {
    return _sharedPreferences.getString(AppConstants.authToken) ??
        AppConstants.empty;
  }

  Future<bool> setPaymentToken(String value) async {
    return await _sharedPreferences.setString(AppConstants.authToken, value);
  }

  Locale getAppLocale() {
    return LanguageType.english.getLocaleFromSharedPref(getAppLanguage());
  }
}
