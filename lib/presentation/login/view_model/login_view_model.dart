import 'dart:async';

import 'package:sneakers_shop/app/app_functions.dart';
import 'package:sneakers_shop/domain/use_cases/login_use_case.dart';
import 'package:sneakers_shop/presentation/common/freezed_data/login_object.dart';
import 'package:sneakers_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:sneakers_shop/presentation/resources/string_manager.dart';

import '../../common/base_view_model/base_view_model.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  final StreamController _usernameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _allInputValidStreamController =
      StreamController<void>.broadcast();
  final LoginObject _loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);
  final StreamController isUserLogin = StreamController<bool>.broadcast();
  @override
  Sink get inputPasswordValid => _passwordStreamController.sink;

  @override
  Sink get inputUsernameValid => _usernameStreamController.sink;
  @override
  Sink get inputAllFieldsValid => _allInputValidStreamController.sink;
  @override
  Stream<bool> get outputPasswordValid => _passwordStreamController.stream
      .map((password) => isPasswordValid(password));

  @override
  Stream<bool> get outputUsernameValid => _usernameStreamController.stream
      .map((username) => isUsernameValid(username));
  @override
  dispose() {
    _usernameStreamController.close();
    _allInputValidStreamController.close();
    _passwordStreamController.close();
    isUserLogin.close();
    super.dispose();
  }

  @override
  Stream<bool> get outputAllFieldsValid =>
      _allInputValidStreamController.stream.map((event) => _checkValidity());

  bool _checkValidity() {
    return isUsernameValid(_loginObject.username) &&
        isPasswordValid(_loginObject.password);
  }

  @override
  void setPassword(String password) {
    _loginObject.copyWith(password: password);
    inputPasswordValid.add(password);
    inputAllFieldsValid.add(null);
  }

  @override
  void setUsername(String username) {
    _loginObject.copyWith(username: username);
    inputUsernameValid.add(username);
    inputAllFieldsValid.add(null);
  }

  @override
  Future login() async {
    inputState.add(LoadingState(
        type: StateRendererType.loadingPopupState,
        message: StringManager.loading));
    (await _loginUseCase.execute(_loginObject)).fold((failure) {
      inputState.add(ErrorState(
          type: StateRendererType.errorPopupState, message: failure.message));
      isUserLogin.add(false);
    }, (authentication) {
      inputState.add(ContentState());
      isUserLogin.add(true);
    });
  }
}

abstract class LoginViewModelInput {
  Sink get inputUsernameValid;
  Sink get inputPasswordValid;
  Sink get inputAllFieldsValid;

  void setUsername(String username);
  void setPassword(String password);
  Future login();
}

abstract class LoginViewModelOutput {
  Stream<bool> get outputUsernameValid;
  Stream<bool> get outputPasswordValid;
  Stream<bool> get outputAllFieldsValid;
}
