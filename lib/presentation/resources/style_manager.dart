import 'package:flutter/material.dart';
import 'font_manager.dart';
import 'size_manager.dart';

class StyleManager {
  static TextStyle _getStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: FontFamilyManager.fontFamily,
    );
  }

  static TextStyle getBoldStyle({
    double fontSize = SizeManager.s12,
    required Color color,
  }) {
    return _getStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeightManager.bold,
    );
  }

  static TextStyle getSemiBoldStyle({
    double fontSize = SizeManager.s12,
    required Color color,
  }) {
    return _getStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeightManager.semiBold,
    );
  }

  static TextStyle getMediumStyle({
    double fontSize = SizeManager.s12,
    required Color color,
  }) {
    return _getStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeightManager.medium,
    );
  }

  static TextStyle getRegularStyle({
    double fontSize = SizeManager.s12,
    required Color color,
  }) {
    return _getStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeightManager.regular,
    );
  }

  static TextStyle getLightStyle({
    double fontSize = SizeManager.s12,
    required Color color,
  }) {
    return _getStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeightManager.light,
    );
  }
}
