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
}
