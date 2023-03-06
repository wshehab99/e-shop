import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../resources/color_manger.dart';
import '../../resources/size_manager.dart';
import 'number_button.dart';

class BagCardListTail extends StatelessWidget {
  const BagCardListTail(
      {super.key,
      required this.itemName,
      required this.itemPrice,
      required this.itemImageUrl,
      required this.numberOfItem,
      required this.decreaseItemNumber,
      required this.increaseItemNumber});
  final int numberOfItem;
  final String itemPrice;
  final String itemName;
  final String itemImageUrl;
  final void Function() increaseItemNumber;
  final void Function() decreaseItemNumber;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeManager.s100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeManager.s100,
            width: SizeManager.s100,
            child: Stack(
              children: [
                const Card(
                  color: ColorManager.lightGrey1,
                  child: SizedBox(
                    height: SizeManager.s80,
                    width: SizeManager.s80,
                  ),
                ),
                Positioned(
                  right: SizeManager.s20,
                  top: SizeManager.s20,
                  child: Transform(
                    transform: Matrix4.rotationZ(-0.5),
                    child: Image.network(
                      itemImageUrl,
                      height: SizeManager.s100,
                      width: SizeManager.s100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: SizeManager.s8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                itemName,
                style: Theme.of(context).textTheme.labelLarge,
              ).tr(),
              Text(
                itemPrice,
                style: Theme.of(context).textTheme.displayLarge,
              ).tr(),
              Row(
                children: [
                  NumberIconButton(
                    icon: Icons.add,
                    onPressed: increaseItemNumber,
                  ),
                  const SizedBox(
                    width: SizeManager.s4,
                  ),
                  Text(
                    numberOfItem.toString(),
                    style: Theme.of(context).textTheme.displayLarge,
                  ).tr(),
                  const SizedBox(
                    width: SizeManager.s4,
                  ),
                  NumberIconButton(
                    icon: Icons.remove,
                    onPressed: decreaseItemNumber,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
