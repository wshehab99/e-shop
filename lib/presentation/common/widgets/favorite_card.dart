import 'package:flutter/material.dart';

import '../../resources/asset_manager.dart';
import '../../resources/color_manger.dart';
import '../../resources/size_manager.dart';
import '../../resources/string_manager.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeManager.s120,
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
                    child: Image.asset(
                      AssetImageManager.nike1,
                      height: SizeManager.s100,
                      width: SizeManager.s100,
                    ),
                  ),
                  Positioned(
                      top: -4,
                      right: -4,
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
                    Text("${StringManager.nike} - ${StringManager.airMax}",
                        style: Theme.of(context).textTheme.displayLarge),
                    Text(StringManager.loremIs,
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(StringManager.price,
                            style: Theme.of(context).textTheme.displayLarge),
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
                            ))
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
    ;
  }
}
