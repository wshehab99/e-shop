import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sneakers_shop/presentation/resources/color_manger.dart';

class RotatedTextBottom extends StatelessWidget {
  const RotatedTextBottom(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isSelected = false});
  final void Function() onPressed;
  final String text;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                side: BorderSide(color: ColorManager.transparent)))),
        child: Text(text,
            style: TextStyle(
                color:
                    isSelected ? ColorManager.black : ColorManager.lightGrey)).tr(),
      ),
    );
  }
}
