enum LanguageType { english, arabic }

extension LanguageTypeExtension on LanguageType {
  String getLanguage() {
    switch (this) {
      case LanguageType.english:
        return "en";
      case LanguageType.arabic:
        return "ar";
    }
  }
}
