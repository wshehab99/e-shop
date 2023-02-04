import 'package:sneakers_shop/presentation/common/base_view_model/base_view_model.dart';

class ProfilePageViewModel extends BaseViewModel
    with ProfileViewModelInput, ProfileViewModelOutput {
  @override
  dispose() {}

  @override
  init() {}

  @override
  logout() {
    // TODO: implement logout
  }

  @override
  switchToOtherAccount() {
    // TODO: implement switchToOtherAccount
  }
}

abstract class ProfileViewModelInput {
  switchToOtherAccount();
  logout();
}

abstract class ProfileViewModelOutput {}
