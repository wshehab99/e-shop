import 'package:flutter/material.dart';

enum LanguageType { english, arabic }

const String arabic = "ar";
const String english = "en";

extension LanguageTypeExtension on LanguageType {
  String getLanguage() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.arabic:
        return arabic;
    }
  }

  Locale getLocale() {
    switch (this) {
      case LanguageType.english:
        return const Locale(english, "us");
      case LanguageType.arabic:
        return const Locale(arabic, "sa");
    }
  }

  Locale getLocaleFromSharedPref(String value) {
    switch (value) {
      case english:
        return const Locale(english, "us");
      case arabic:
        return const Locale(arabic, "sa");
      default:
        return const Locale(english, "us");
    }
  }
}

class LanguageModel {
  String language;
  String value;
  LanguageModel({required this.language, required this.value});
  static final List<LanguageModel> appLangues = [
    LanguageModel(language: "English", value: english),
    LanguageModel(language: "Arabic", value: arabic),
  ];
}
