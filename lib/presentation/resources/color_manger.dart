import 'dart:math';

import 'package:flutter/material.dart';

class ColorManager {
  static const Color primary = Color(0xffED9728);
  static const Color darkGrey = Color(0xff525252);
  static const Color grey = Color(0xff737477);
  static const Color black = Color(0xff000000);
  static const Color transparent = Color(0x00000000);
  static const Color lightGrey = Color(0xff9E9E9E);
  static const Color lightGrey1 = Color(0xffECECEC);
  static const Color darkPrimary = Color(0xffd17d11);
  static const Color lightPrimary = Color(0xCCd17d11); // color with 80% opacity
  static const Color grey1 = Color(0xff707070);
  static const Color grey2 = Color(0xff797979);
  static const Color white = Color(0xffFFFFFF);
  static const Color error = Color(0xffe61f34);
  static const Color offWhite = Color(0xFFFAF9F6);
  static const Color deepGreen = Color(0xFF06800a);
  static const Color blue = Color(0xff19BDFF);
  static const List<Color> _list = [
    Color(0xffED9728),
    Color(0xff19BDFF),
    Color(0xff317773),
    Color(0xff00FFFF),
    Color(0xffFF69B4),
    Color(0xffEE4E34),
    Color(0xffAA9ADA),
    Color(0xff234E70),
    Color(0xff1E2761),
    Color(0xff7A2048),
  ];
  static Color randomColor() {
    return _list[Random().nextInt(_list.length)];
  }
}
