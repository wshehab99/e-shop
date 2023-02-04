import 'package:flutter/material.dart';
import 'package:sneakers_shop/presentation/resources/color_manger.dart';
import 'package:sneakers_shop/presentation/resources/size_manager.dart';

class NumberIconButton extends StatelessWidget {
  const NumberIconButton(
      {super.key, required this.icon, required this.onPressed});
  final void Function() onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(SizeManager.s3),
          decoration: BoxDecoration(
              color: ColorManager.lightGrey1,
              borderRadius: BorderRadius.circular(SizeManager.s8)),
          child: Icon(
            icon,
            size: SizeManager.s14,
          ),
        ));
  }
}
