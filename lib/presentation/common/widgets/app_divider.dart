import 'package:flutter/material.dart';

import '../../resources/color_manger.dart';
import '../../resources/size_manager.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeManager.s10),
      child: Divider(
        color: ColorManager.lightGrey,
      ),
    );
  }
}
