import 'package:sneakers_shop/presentation/common/base_view_model/base_view_model.dart';

class HomeViewMode1 extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  @override
  dispose() {
    // TODO: implement dispose
    throw UnimplementedError();
  }

  @override
  getFeed() {
    // TODO: implement getFeed
    throw UnimplementedError();
  }

  @override
  init() {
    // TODO: implement init
    throw UnimplementedError();
  }
}

abstract class HomeViewModelInput {
  getFeed();
}

abstract class HomeViewModelOutput {}
