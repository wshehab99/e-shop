import 'package:flutter/material.dart';

import '../../../../../app/dependency_injection.dart';
import '../../../../../domain/model/derails_object.dart';
import '../../../../../domain/model/home_model.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../common/widgets/featured_product_card.dart';
import '../../../../common/widgets/rotated_text_bottom.dart';
import '../../../../resources/color_manger.dart';
import '../../../../resources/pref_manager.dart';
import '../../../../resources/route_manger.dart';
import '../../../../resources/size_manager.dart';
import '../../../../resources/string_manager.dart';
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
    return StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.renderWidget(context, _getContent()) ??
              _getContent();
        });
  }

  Widget _getHorizontalList() {
    return SizedBox(
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
                          isSelected:
                              snapshot.hasData ? i == snapshot.data : i == 0,
                        ),
                    ],
                  );
                }),
            const SizedBox(
              width: SizeManager.s10,
            ),
            _getHorizontalItemsList(),
          ],
        ),
      ),
    );
  }

  Widget _getHorizontalItemsList() {
    return StreamBuilder<List<ProductResponseModel>>(
        stream: _viewModel.outputShownList,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: PrefManager.neverScrollPhysics,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final Color color = ColorManager.randomColor();
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            RouteManager.sneakerDetailsRoute,
                            arguments:
                                DetailsObject(snapshot.data![index], color));
                      },
                      child: FeaturedProductCard(
                        product: snapshot.data![index],
                        color: color,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        width: SizeManager.s20,
                      ),
                  itemCount: snapshot.data!.length)
              : const SizedBox();
        });
  }

  Widget _getContent() {
    return SingleChildScrollView(
      physics: PrefManager.appScrollPhysics,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getHorizontalList(),
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
          _getGridItems(),
        ],
      ),
    );
  }

  Widget _getGridItems() {
    return StreamBuilder<List<ProductResponseModel>>(
        stream: _viewModel.outputMoreList,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: PrefManager.neverScrollPhysics,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(SizeManager.s10),
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Align(
                              alignment: Alignment.topRight,
                              child: Icon(Icons.favorite_border),
                            ),
                            Image.network(
                              snapshot.data![index].imgUrl,
                              fit: BoxFit.cover,
                              height: SizeManager.s80,
                            ),
                            Text(
                              "${snapshot.data![index].brand} ${snapshot.data![index].model}",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            Text(
                              snapshot.data![index].price.toString(),
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ]),
                    ),
                  ),
                  itemCount: snapshot.data!.length,
                )
              : const SizedBox();
        });
  }
}
