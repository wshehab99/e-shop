import 'package:flutter/material.dart';

abstract class PrefManager {
  static const ScrollPhysics appScrollPhysics = BouncingScrollPhysics();
  static const ScrollPhysics neverScrollPhysics =
      NeverScrollableScrollPhysics();
}
