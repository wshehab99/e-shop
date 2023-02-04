import 'package:flutter/material.dart';
import 'package:sneakers_shop/presentation/resources/asset_manager.dart';
import 'package:sneakers_shop/presentation/resources/color_manger.dart';
import 'package:sneakers_shop/presentation/resources/route_manger.dart';
import 'package:sneakers_shop/presentation/resources/size_manager.dart';
import 'package:sneakers_shop/presentation/resources/string_manager.dart';

import '../../../../common/widgets/featured_product_card.dart';
import '../../../../common/widgets/rotated_text_bottom.dart';
import '../../../../resources/pref_manager.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: PrefManager.appScrollPhysics,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeManager.s200,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: PrefManager.appScrollPhysics,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RotatedTextBottom(
                        onPressed: () {},
                        text: StringManager.upcoming,
                      ),
                      RotatedTextBottom(
                        onPressed: () {},
                        text: StringManager.featured,
                        isSelected: true,
                      ),
                      RotatedTextBottom(
                        onPressed: () {},
                        text: StringManager.news,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: SizeManager.s10,
                  ),
                  ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: PrefManager.neverScrollPhysics,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(RouteManager.sneakerDetailsRoute);
                            },
                            child: const FeaturedProductCard(
                              brand: StringManager.nike,
                              model: StringManager.airMax,
                              price: StringManager.price,
                              imgUrl: AssetImageManager.nike1,
                              color: ColorManager.primary,
                            ),
                          ),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: SizeManager.s20,
                          ),
                      itemCount: 10),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: SizeManager.s20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringManager.more,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Icon(
                Icons.arrow_right,
                size: SizeManager.s35,
              )
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: PrefManager.neverScrollPhysics,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) => Card(
              child: Padding(
                padding: const EdgeInsets.all(SizeManager.s10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.favorite_border),
                      ),
                      Image.asset(
                        AssetImageManager.nike1,
                        height: SizeManager.s50,
                      ),
                      Text(
                        "${StringManager.nike} ${StringManager.airMax}",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        StringManager.price,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ]),
              ),
            ),
            itemCount: 10,
          )
        ],
      ),
    );
  }
}
