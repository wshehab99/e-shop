import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sneakers_shop/domain/model/home_model.dart';

import '../../resources/color_manger.dart';
import '../../resources/size_manager.dart';
import '../../resources/string_manager.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key, required this.product});
  final ProductResponseModel product;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeManager.s150,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(SizeManager.s8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(SizeManager.s10),
                    decoration: const BoxDecoration(
                      color: ColorManager.lightGrey1,
                      borderRadius: BorderRadius.all(
                        Radius.circular(SizeManager.s10),
                      ),
                    ),
                    child: Image.network(
                      product.imgUrl,
                      height: SizeManager.s100,
                      width: SizeManager.s100,
                    ),
                  ),
                  Positioned(
                      top: SizeManager.ns4,
                      right: SizeManager.ns4,
                      child: IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: ColorManager.error,
                        ),
                        onPressed: () {},
                      ))
                ],
              ),
              const SizedBox(
                width: SizeManager.s10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${product.brand} - ${product.model}",
                        style: Theme.of(context).textTheme.displayLarge).tr(),
                    Text(StringManager.loremIs,
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true).tr(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product.price.toString(),
                            style: Theme.of(context).textTheme.displayLarge).tr(),
                        ElevatedButton(
                            onPressed: () {},
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style!
                                .copyWith(
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                      horizontal: SizeManager.s8,
                                    )),
                                    textStyle: MaterialStateProperty.all(
                                        const TextStyle(
                                            fontSize: SizeManager.s12))),
                            child: const Text(
                              StringManager.addToCart,
                            ).tr())
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
