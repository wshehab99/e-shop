import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sneakers_shop/domain/model/derails_object.dart';

import '../../common/widgets/app_divider.dart';
import '../../resources/color_manger.dart';
import '../../resources/pref_manager.dart';
import '../../resources/size_manager.dart';
import '../../resources/string_manager.dart';
import '../view_model/sneaker_details_view_model.dart';

class SneakerDetailsView extends StatefulWidget {
  const SneakerDetailsView({super.key, required this.object});
  final DetailsObject object;
  @override
  State<SneakerDetailsView> createState() => _SneakerDetailsViewState();
}

class _SneakerDetailsViewState extends State<SneakerDetailsView> {
  final SneakersDetailsViewModel _viewModel = SneakersDetailsViewModel();

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
    final double top = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SingleChildScrollView(
        physics: PrefManager.appScrollPhysics,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: SizeManager.s14, top: top),
                    height: MediaQuery.of(context).size.height / 2.25,
                    decoration: BoxDecoration(
                        color: widget.object.color,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(SizeManager.s400),
                        )),
                  ),
                  Positioned(
                    left: SizeManager.s0,
                    bottom: SizeManager.s0,
                    child: Transform(
                      transform: Matrix4.rotationZ(-0.35),
                      child: Image.network(
                        widget.object.product.imgUrl,
                        height: SizeManager.s150,
                      ),
                    ),
                  ),
                  Positioned(
                    left: SizeManager.s8,
                    top: top,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios,
                          color: ColorManager.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: SizeManager.s16,
            ),
            const AppDivider(),
            const SizedBox(
              height: SizeManager.s16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.object.product.model,
                    style: Theme.of(context).textTheme.titleMedium,
                  ).tr(),
                  Text(
                    widget.object.product.price.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ).tr(),
                ],
              ),
            ),
            const SizedBox(
              height: SizeManager.s16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
              child: Text(
                StringManager.loremIs,
                style: Theme.of(context).textTheme.bodyLarge,
              ).tr(),
            ),
            const SizedBox(
              height: SizeManager.s16,
            ),
            _setCurrency(),
            const SizedBox(
              height: SizeManager.s16,
            ),
            _setSizes(),
            const SizedBox(
              height: SizeManager.s50,
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(SizeManager.s10),
        child: SizedBox(
          width: double.infinity,
          child: StreamBuilder<bool>(
              stream: _viewModel.outputAllValid,
              builder: (context, snapshot) {
                return ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          widget.object.color)),
                  onPressed: snapshot.hasData && snapshot.data! ? () {} : null,
                  child: const Text(StringManager.addToCart).tr(),
                );
              }),
        ),
      ),
    );
  }

  Widget _setCurrency() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            StringManager.size,
            style: Theme.of(context).textTheme.titleMedium,
          ).tr(),
          StreamBuilder<List<Currency>>(
              stream: _viewModel.outputCurrency,
              builder: (context, snapshot) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: snapshot.hasData
                        ? [
                            for (int i = 0; i < snapshot.data!.length; i++)
                              IconButton(
                                  onPressed: () {
                                    _viewModel.setSelectedCurrency(i);
                                  },
                                  icon: Text(
                                    snapshot.data![i].currency,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: snapshot.data![i].isSelected
                                              ? ColorManager.black
                                              : ColorManager.lightGrey,
                                        ),
                                  ).tr())
                          ]
                        : []);
              }),
        ],
      ),
    );
  }

  Widget _setSizes() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
      child: SingleChildScrollView(
        physics: PrefManager.appScrollPhysics,
        scrollDirection: Axis.horizontal,
        child: StreamBuilder<List<SneakerSize>>(
            stream: _viewModel.outputSize,
            builder: (context, snapshot) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: snapshot.hasData
                      ? [
                          for (int i = 0; i < snapshot.data!.length; i++)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: TextButton(
                                onPressed: () {
                                  _viewModel.setSelectedSize(i);
                                },
                                style: Theme.of(context)
                                    .textButtonTheme
                                    .style!
                                    .copyWith(
                                        backgroundColor: snapshot
                                                .data![i].isSelected
                                            ? MaterialStateProperty.all<Color>(
                                                ColorManager.black)
                                            : MaterialStateProperty.all<Color>(
                                                ColorManager.offWhite)),
                                child: Text(
                                  snapshot.data![i].size.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: snapshot.data![i].isSelected
                                            ? ColorManager.white
                                            : ColorManager.lightGrey,
                                      ),
                                ).tr(),
                              ),
                            ),
                          const SizedBox(
                            width: SizeManager.s10,
                          ),
                        ]
                      : []);
            }),
      ),
    );
  }
}
