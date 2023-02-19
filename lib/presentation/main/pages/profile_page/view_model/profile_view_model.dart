import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sneakers_shop/domain/model/settings_model.dart';
import 'package:sneakers_shop/domain/use_cases/settings_use_case.dart';
import 'package:sneakers_shop/presentation/base_view_model/base_view_model.dart';
import 'package:sneakers_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:sneakers_shop/presentation/resources/string_manager.dart';

class ProfilePageViewModel extends BaseViewModel
    with ProfileViewModelInput, ProfileViewModelOutput {
  final StreamController _settingsStreamController =
      BehaviorSubject<SettingsModel>();
  final StreamController _paymentStreamController = BehaviorSubject<bool>();
  final StreamController _privacyStreamController = BehaviorSubject<bool>();

  final StreamController _achievementStreamController = BehaviorSubject<bool>();
  final StreamController _languageStreamController = BehaviorSubject<bool>();
  final SettingsUseCase _useCase;
  ProfilePageViewModel(this._useCase);
  bool _achievement = false;
  bool _privacy = false;
  bool _payment = false;
  bool _language = false;

  @override
  Sink get inputSettings => _settingsStreamController.sink;
  @override
  Sink get inputAchievementShown => _achievementStreamController.sink;

  @override
  Sink get inputLanguagesShown => _languageStreamController.sink;

  @override
  Sink get inputPaymentShown => _paymentStreamController.sink;

  @override
  Sink get inputPrivacyShown => _privacyStreamController.sink;

  @override
  Stream<bool> get outputAchievementShown =>
      _achievementStreamController.stream.map((event) => event);

  @override
  Stream<bool> get outputLanguagesShown =>
      _languageStreamController.stream.map((event) => event);

  @override
  Stream<bool> get outputPaymentShown =>
      _paymentStreamController.stream.map((event) => event);

  @override
  Stream<bool> get outputPrivacyShown =>
      _privacyStreamController.stream.map((event) => event);
  @override
  Stream<SettingsModel> get outputSettings =>
      _settingsStreamController.stream.map((event) => event);
  @override
  init() {
    super.init();
    getSettings();
    _addData();
  }

  @override
  dispose() {
    _settingsStreamController.close();
    _achievementStreamController.close();
    _paymentStreamController.close();
    _privacyStreamController.close();
    _languageStreamController.close();

    super.dispose();
  }

  @override
  logout() {}

  @override
  switchToOtherAccount() {}

  @override
  getSettings() async {
    inputState.add(LoadingState(
        type: StateRendererType.loadingFullScreenState,
        message: StringManager.loading));
    (await _useCase.execute(null)).fold((failure) {
      inputState.add(ErrorState(
          type: StateRendererType.errorFullScreenState,
          message: failure.message));
    }, (settingsModel) {
      inputSettings.add(settingsModel);
      inputState.add(ContentState());
    });
  }

  @override
  showUnShowAchievement() {
    _achievement = !_achievement;
    inputAchievementShown.add(_achievement);
  }

  @override
  showUnShowLanguages() {
    _language = !_language;
    inputLanguagesShown.add(_language);
  }

  @override
  showUnShowPayment() {
    _payment = !_payment;
    inputPaymentShown.add(_payment);
  }

  @override
  showUnShowPrivacy() {
    _privacy = !_privacy;
    inputPrivacyShown.add(_privacy);
  }

  _addData() {
    inputAchievementShown.add(_achievement);
    inputLanguagesShown.add(_language);
    inputPaymentShown.add(_payment);
    inputPrivacyShown.add(_privacy);
  }
}

abstract class ProfileViewModelInput {
  Sink get inputSettings;
  Sink get inputPaymentShown;
  Sink get inputAchievementShown;
  Sink get inputPrivacyShown;
  Sink get inputLanguagesShown;
  getSettings();
  switchToOtherAccount();
  logout();
  showUnShowPayment();
  showUnShowAchievement();
  showUnShowLanguages();
  showUnShowPrivacy();
}

abstract class ProfileViewModelOutput {
  Stream<SettingsModel> get outputSettings;
  Stream<bool> get outputPaymentShown;
  Stream<bool> get outputAchievementShown;
  Stream<bool> get outputPrivacyShown;
  Stream<bool> get outputLanguagesShown;
}
