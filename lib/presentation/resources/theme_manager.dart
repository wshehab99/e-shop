import 'package:flutter/material.dart';
import 'package:sneakers_shop/presentation/resources/style_manager.dart';

import 'color_manger.dart';
import 'size_manager.dart';

abstract class ThemeManager {
  static ThemeData appTheme = ThemeData(
    //dialog theme
    dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeManager.s14),
        ),
        elevation: SizeManager.s1,
        backgroundColor: ColorManager.transparent),
    scaffoldBackgroundColor: ColorManager.offWhite,

    // main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,

    // cardView theme
    cardTheme: const CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: SizeManager.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(SizeManager.s10),
        ),
      ),
    ),
    // app bar theme
    appBarTheme: AppBarTheme(
      color: ColorManager.offWhite,
      elevation: SizeManager.s0,
      shadowColor: ColorManager.offWhite,
      centerTitle: false,
      iconTheme: const IconThemeData(color: ColorManager.black, size: 25),
      titleTextStyle: StyleManager.getBoldStyle(
        fontSize: SizeManager.s22,
        color: ColorManager.black,
      ),
    ),
    // button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),
    // elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
            StyleManager.getRegularStyle(
              color: ColorManager.white,
              fontSize: SizeManager.s17,
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color?>(
            ColorManager.primary,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                SizeManager.s12,
              ),
            ),
          )),
    ),
    iconTheme: const IconThemeData(color: ColorManager.black),
    // text theme
    textTheme: TextTheme(
      headlineLarge: StyleManager.getSemiBoldStyle(
        color: ColorManager.darkGrey,
        fontSize: SizeManager.s16,
      ),
      headlineMedium: StyleManager.getBoldStyle(
        color: ColorManager.white,
        fontSize: SizeManager.s20,
      ),
      titleMedium: StyleManager.getMediumStyle(
        color: ColorManager.black,
        fontSize: SizeManager.s16,
      ),
      labelLarge: StyleManager.getRegularStyle(
        color: ColorManager.black,
        fontSize: SizeManager.s14,
      ),
      headlineSmall: StyleManager.getRegularStyle(
        color: ColorManager.white,
        fontSize: SizeManager.s14,
      ),
      bodyLarge: StyleManager.getRegularStyle(
        color: ColorManager.grey,
        fontSize: SizeManager.s12,
      ),
      bodyMedium: StyleManager.getBoldStyle(
        color: ColorManager.black,
        fontSize: SizeManager.s18,
      ),
      displayLarge: StyleManager.getSemiBoldStyle(
        color: ColorManager.black,
        fontSize: SizeManager.s14,
      ),
      titleSmall: StyleManager.getRegularStyle(
        color: ColorManager.white,
        fontSize: SizeManager.s16,
      ),
      displaySmall: StyleManager.getLightStyle(
        color: ColorManager.black,
        fontSize: SizeManager.s12,
      ),
    ),
    //bottomNavigationBarTheme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: SizeManager.s4,
      backgroundColor: ColorManager.white,
      unselectedIconTheme: IconThemeData(color: ColorManager.lightGrey),
      selectedIconTheme: IconThemeData(color: ColorManager.primary),
      selectedItemColor: ColorManager.primary,
    ),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: ColorManager.transparent),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(ColorManager.offWhite),
          shape:
              MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                  side: const BorderSide(color: ColorManager.lightGrey),
                  borderRadius: BorderRadius.circular(
                    SizeManager.s10,
                  ))),
          textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(fontSize: SizeManager.s10))),
    ),
  );
}
