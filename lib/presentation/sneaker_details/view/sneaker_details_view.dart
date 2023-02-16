import 'package:flutter/material.dart';
import '../../common/widgets/app_divider.dart';
import '../../resources/asset_manager.dart';
import '../../resources/color_manger.dart';
import '../../resources/size_manager.dart';
import '../../resources/string_manager.dart';
import '../view_model/sneaker_details_view_model.dart';

class SneakerDetailsView extends StatefulWidget {
  const SneakerDetailsView({super.key});

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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeManager.s14,
                        top: MediaQuery.of(context).padding.top),
                    height: MediaQuery.of(context).size.height / 2.25,
                    decoration: const BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(400),
                        )),
                  ),
                  Positioned(
                    left: SizeManager.s0,
                    top: SizeManager.s100,
                    child: Transform(
                      transform: Matrix4.rotationZ(-0.35),
                      child: Image.asset(
                        AssetImageManager.nike1,
                        height: SizeManager.s150,
                      ),
                    ),
                  ),
                  Positioned(
                    left: SizeManager.s8,
                    top: SizeManager.s8,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SizeManager.s10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      AssetImageManager.nike1,
                      height: SizeManager.s35,
                    ),
                    const SizedBox(
                      width: SizeManager.s16,
                    ),
                    Image.asset(
                      AssetImageManager.nike1,
                      height: SizeManager.s35,
                    ),
                    const SizedBox(
                      width: SizeManager.s16,
                    ),
                    Image.asset(
                      AssetImageManager.nike1,
                      height: SizeManager.s35,
                    ),
                    const SizedBox(
                      width: SizeManager.s16,
                    ),
                    Image.asset(
                      AssetImageManager.nike1,
                      height: SizeManager.s35,
                    ),
                  ],
                ),
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
                    StringManager.zoom,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    StringManager.price,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
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
              ),
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
                  onPressed: snapshot.hasData && snapshot.data! ? () {} : null,
                  child: const Text(StringManager.addToCart),
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
          ),
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
                                  ))
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
                                ),
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
