import 'dart:async';

import 'package:sneakers_shop/presentation/common/freezed_data/login_object.dart';

import '../../../app/app_functions.dart';
import '../../common/base_view_model/base_view_model.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController _passwordStreamController = StreamController<String>();
  final StreamController _usernameStreamController = StreamController<String>();
  final StreamController _allValidStreamController = StreamController<void>();
  final LoginObject _loginObject = LoginObject("", "");
//inputs
  @override
  Sink get inputAllFieldsValid => _allValidStreamController.sink;

  @override
  Sink get inputPasswordValid => _passwordStreamController.sink;

  @override
  Sink get inputUsernameValid => _usernameStreamController.sink;
//outputs
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
  Future register() async {}

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

  bool _allInputValid() {
    return isUsernameValid(_loginObject.username) &&
        isPasswordValid(_loginObject.password);
  }
}

abstract class RegisterViewModelInput {
  Sink get inputUsernameValid;
  Sink get inputPasswordValid;
  Sink get inputAllFieldsValid;

  void setUsername(String username);
  void setPassword(String password);
  Future register();
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputUsernameValid;
  Stream<bool> get outputPasswordValid;
  Stream<bool> get outputAllFieldsValid;
}
