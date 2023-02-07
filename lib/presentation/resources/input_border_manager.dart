import 'package:flutter/material.dart';
import 'package:sneakers_shop/presentation/resources/size_manager.dart';

class InputBorderManager {
  static getInputBorder({required Color color}) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: SizeManager.s1),
        borderRadius: const BorderRadius.all(Radius.circular(SizeManager.s8)));
  }
}
