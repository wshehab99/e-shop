import 'package:flutter/material.dart';
import 'package:sneakers_shop/app/dependency_injection.dart';
import 'package:sneakers_shop/domain/model/home_model.dart';
import 'package:sneakers_shop/presentation/resources/color_manger.dart';
import 'package:sneakers_shop/presentation/resources/route_manger.dart';
import 'package:sneakers_shop/presentation/resources/size_manager.dart';
import 'package:sneakers_shop/presentation/resources/string_manager.dart';

import '../../../../common/widgets/featured_product_card.dart';
import '../../../../common/widgets/rotated_text_bottom.dart';
import '../../../../resources/pref_manager.dart';
import '../view_model/home_view_model.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final HomeViewMode1 _viewModel =
      DependencyInjection.instance<HomeViewMode1>();
  final List<String> _list = [
    StringManager.upcoming,
    StringManager.featured,
    StringManager.news,
  ];
  @override
  void initState() {
    _viewModel.init();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

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
                  StreamBuilder<int>(
                      stream: _viewModel.outputSelectedIndex,
                      builder: (context, snapshot) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < _list.length; i++)
                              RotatedTextBottom(
                                onPressed: () {
                                  _viewModel.changeIndex(i);
                                },
                                text: _list[i],
                                isSelected: i == snapshot.data,
                              ),
                          ],
                        );
                      }),
                  const SizedBox(
                    width: SizeManager.s10,
                  ),
                  StreamBuilder<List<ProductResponseModel>>(
                      stream: null,
                      builder: (context, snapshot) {
                        List shownList = snapshot.data ?? [];
                        return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: PrefManager.neverScrollPhysics,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        RouteManager.sneakerDetailsRoute);
                                  },
                                  child: FeaturedProductCard(
                                    product: shownList[index],
                                    color: ColorManager.primary,
                                  ),
                                ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  width: SizeManager.s20,
                                ),
                            itemCount: shownList.length);
                      }),
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
          StreamBuilder<List<ProductResponseModel>>(
              stream: _viewModel.outputMoreList,
              builder: (context, snapshot) {
                List<ProductResponseModel> shownList = snapshot.data ?? [];
                return GridView.builder(
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
                            Image.network(
                              shownList[index].imgUrl,
                              height: SizeManager.s50,
                            ),
                            Text(
                              "${shownList[index].brand} ${shownList[index].model}",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            Text(
                              shownList[index].price.toString(),
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ]),
                    ),
                  ),
                  itemCount: shownList.length,
                );
              })
        ],
      ),
    );
  }
}
