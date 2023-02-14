import 'package:sneakers_shop/presentation/common/base_view_model/base_view_model.dart';

class HomeViewMode1 extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  @override
  getFeed() {
    // TODO: implement getFeed
    throw UnimplementedError();
  }
}

abstract class HomeViewModelInput {
  getFeed();
}

abstract class HomeViewModelOutput {}
