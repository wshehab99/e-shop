import 'dart:async';

import 'package:sneakers_shop/domain/use_cases/register_use_case.dart';
import 'package:sneakers_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:sneakers_shop/presentation/resources/string_manager.dart';

import '../../../app/app_functions.dart';
import '../../common/base_view_model/base_view_model.dart';
import '../../common/freezed_data/register_object.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController _passwordStreamController = StreamController<String>();
  final StreamController _usernameStreamController = StreamController<String>();
  final StreamController _nameStreamController = StreamController<String>();
  final StreamController _allValidStreamController = StreamController<void>();
  final RegisterObject _loginObject = RegisterObject("", "", "");
  final RegisterUseCase _useCase;
  RegisterViewModel(this._useCase);
  final StreamController isRegistered = StreamController<bool>.broadcast();

//inputs
  @override
  Sink get inputAllFieldsValid => _allValidStreamController.sink;

  @override
  Sink get inputPasswordValid => _passwordStreamController.sink;

  @override
  Sink get inputUsernameValid => _usernameStreamController.sink;
  @override
  Sink get inputNameValid => _nameStreamController.sink;
//outputs

  @override
  Stream<bool> get outputNameValid =>
      _nameStreamController.stream.map((name) => isUsernameValid(name));
  @override
  Stream<bool> get outputPasswordValid => _passwordStreamController.stream
      .map((password) => isPasswordValid(password));

  @override
  Stream<bool> get outputUsernameValid => _usernameStreamController.stream
      .map((username) => isUsernameValid(username));
  @override
  Stream<bool> get outputAllFieldsValid =>
      _allValidStreamController.stream.map((_) => _allInputValid());
  @override
  dispose() {
    _passwordStreamController.close();
    _usernameStreamController.close();
    _allValidStreamController.close();
    super.dispose();
  }

  @override
  Future register() async {
    inputState.add(LoadingState(
        type: StateRendererType.loadingPopupState,
        message: StringManager.loading));
    (await _useCase.execute(_loginObject)).fold((failure) {
      inputState.add(ErrorState(
          type: StateRendererType.errorPopupState, message: failure.message));
    }, (auth) {
      inputState.add(ContentState());
      isRegistered.add(true);
    });
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
  void setName(String name) {
    _loginObject.copyWith(name: name);
    inputNameValid.add(name);
    inputAllFieldsValid.add(null);
  }

  bool _allInputValid() {
    return isUsernameValid(_loginObject.username) &&
        isPasswordValid(_loginObject.password) &&
        isUsernameValid(_loginObject.name);
  }
}

abstract class RegisterViewModelInput {
  Sink get inputUsernameValid;
  Sink get inputPasswordValid;
  Sink get inputNameValid;
  Sink get inputAllFieldsValid;

  void setUsername(String username);
  void setPassword(String password);
  void setName(String name);

  Future register();
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputUsernameValid;
  Stream<bool> get outputPasswordValid;
  Stream<bool> get outputNameValid;
  Stream<bool> get outputAllFieldsValid;
}
