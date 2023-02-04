import 'package:flutter/material.dart';
import 'package:sneakers_shop/presentation/resources/color_manger.dart';

import '../../resources/size_manager.dart';

class FeaturedProductCard extends StatelessWidget {
  const FeaturedProductCard(
      {super.key,
      required this.brand,
      required this.model,
      required this.price,
      required this.imgUrl,
      this.color = ColorManager.primary});
  final Color color;
  final String brand;
  final String model;
  final String price;
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeManager.s170,
      child: Stack(
        children: [
          Container(
            width: SizeManager.s150,
            padding: const EdgeInsets.all(SizeManager.s10),
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(SizeManager.s24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      brand,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.favorite_border,
                      color: ColorManager.white,
                    )
                  ],
                ),
                const SizedBox(
                  height: SizeManager.s20,
                ),
                Text(
                  model,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  price,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Spacer(),
                const Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(Icons.arrow_circle_right_outlined,
                        color: ColorManager.white)),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 100,
            child: Transform(
              transform: Matrix4.rotationZ(-0.5),
              child: Image.asset(
                imgUrl,
                height: SizeManager.s60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
