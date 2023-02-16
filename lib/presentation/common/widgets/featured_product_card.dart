import 'package:flutter/material.dart';

import '../../../domain/model/home_model.dart';
import '../../resources/color_manger.dart';
import '../../resources/size_manager.dart';

class FeaturedProductCard extends StatelessWidget {
  const FeaturedProductCard(
      {super.key, required this.product, this.color = ColorManager.primary});
  final ProductResponseModel product;
  final Color color;

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
                      product.brand,
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
                  product.model,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  product.price.toString(),
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
            right: SizeManager.s0,
            top: SizeManager.s100,
            child: Transform(
              transform: Matrix4.rotationZ(-0.5),
              child: Image.network(
                product.imgUrl,
                height: SizeManager.s60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
