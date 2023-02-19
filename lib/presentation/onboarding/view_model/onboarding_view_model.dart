import 'dart:async';

import 'package:sneakers_shop/domain/model/onboarding_model.dart';
import 'package:sneakers_shop/presentation/resources/asset_manager.dart';
import 'package:sneakers_shop/presentation/resources/string_manager.dart';

import '../../../domain/model/slider_object_model.dart';
import '../../base_view_model/base_view_model.dart';

class OnboardingViewModel extends BaseViewModel
    with OnboardingViewModelInput, OnboardingViewModelOutput {
  final StreamController _currentIndexStreamController =
      StreamController<SliderObjectModel>();
  late List<OnboardingModel> _pages;
  int _currentIndex = 0;
  @override
  Sink get inputCurrentPage => _currentIndexStreamController.sink;

  @override
  Stream<SliderObjectModel> get outputCurrentPage =>
      _currentIndexStreamController.stream.map((index) => index);
  @override
  dispose() {
    _currentIndexStreamController.close();
    super.dispose();
  }

  @override
  init() {
    _pages = _getPages();
    _postDataToView();
    super.init();
  }

  @override
  int nextPage() {
    _currentIndex++;
    if (_currentIndex == _pages.length) {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  @override
  int previousPage() {
    _currentIndex--;
    if (_currentIndex == -1) {
      _currentIndex = _pages.length - 1;
    }
    return _currentIndex;
  }

  void _postDataToView() {
    inputCurrentPage.add(
        SliderObjectModel(_pages[_currentIndex], _currentIndex, _pages.length));
  }

  List<OnboardingModel> _getPages() {
    return <OnboardingModel>[
      OnboardingModel(
          title: StringManager.onboardingTitle1,
          subTitle: StringManager.onboardingSubTitle1,
          imagePath: AssetImageManager.onboarding1),
      OnboardingModel(
          title: StringManager.onboardingTitle2,
          subTitle: StringManager.onboardingSubTitle2,
          imagePath: AssetImageManager.onboarding2),
      OnboardingModel(
          title: StringManager.onboardingTitle3,
          subTitle: StringManager.onboardingSubTitle3,
          imagePath: AssetImageManager.onboarding3),
    ];
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }
}

abstract class OnboardingViewModelInput {
  Sink get inputCurrentPage;
  int nextPage();
  int previousPage();
  void onPageChanged(int index);
}

abstract class OnboardingViewModelOutput {
  Stream<SliderObjectModel> get outputCurrentPage;
}
