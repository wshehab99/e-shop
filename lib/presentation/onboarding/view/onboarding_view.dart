import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sneakers_shop/app/dependency_injection.dart';
import 'package:sneakers_shop/presentation/onboarding/view_model/onboarding_view_model.dart';
import 'package:sneakers_shop/presentation/resources/asset_manager.dart';
import 'package:sneakers_shop/presentation/resources/size_manager.dart';

import '../../../app/app_constant.dart';
import '../../../domain/model/slider_object_model.dart';
import '../../common/widgets/onboarding_page.dart';
import '../../resources/color_manger.dart';
import '../../resources/route_manger.dart';
import '../../resources/string_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
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

  final OnboardingViewModel _viewModel =
      DependencyInjection.instance<OnboardingViewModel>();
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderObjectModel>(
        stream: _viewModel.outputCurrentPage,
        builder: (context, snapshot) {
          return Scaffold(
            body: snapshot.hasData
                ? Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top,
                        left: SizeManager.s10,
                        right: SizeManager.s10),
                    child: PageView.builder(
                      controller: _controller,
                      itemBuilder: (context, index) {
                        return OnboardingPage(
                          page: snapshot.data!.data,
                        );
                      },
                      onPageChanged: _viewModel.onPageChanged,
                      itemCount: snapshot.data!.numberOfItems,
                    ),
                  )
                : const SizedBox(),
            bottomSheet: snapshot.hasData
                ? Container(
                    color: ColorManager.white,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          child: Text(
                            StringManager.skip,
                            style: Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.end,
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, RouteManager.login);
                          },
                        ),
                      ),
                      _getBottomSheetIndicator(snapshot.data!),
                    ]),
                  )
                : const SizedBox(),
          );
        });
  }

  Widget _getBottomSheetIndicator(SliderObjectModel slider) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              _controller.animateToPage(_viewModel.previousPage(),
                  duration:
                      const Duration(milliseconds: AppConstants.pageDelay),
                  curve: Curves.bounceInOut);
            },
            icon: SvgPicture.asset(
              AssetImageManager.leftArrowIc,
            ),
          ),
          Row(
            children: [
              for (int i = 0; i < slider.numberOfItems; i++)
                Padding(
                  padding: const EdgeInsets.all(SizeManager.s8),
                  child: _getProperCircle(i, slider.currentIndex),
                )
            ],
          ),
          IconButton(
            onPressed: () {
              _controller.animateToPage(_viewModel.nextPage(),
                  duration:
                      const Duration(milliseconds: AppConstants.pageDelay),
                  curve: Curves.bounceInOut);
            },
            icon: SvgPicture.asset(
              AssetImageManager.rightArrowIc,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    return SvgPicture.asset(index == currentIndex
        ? AssetImageManager.hollowCircleIc
        : AssetImageManager.solidCircleIc);
  }
}
