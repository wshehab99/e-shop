import 'dart:async';

import 'package:sneakers_shop/domain/model/favorite_model.dart';
import 'package:sneakers_shop/domain/use_cases/favorite_use_case.dart';
import 'package:sneakers_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:sneakers_shop/presentation/resources/string_manager.dart';

import '../../../../../domain/model/home_model.dart';
import '../../../../common/base_view_model/base_view_model.dart';

class FavoritePageViewModel extends BaseViewModel
    with FavoritePageViewModelInput, FavoritePageViewModelOutput {
  final FavoriteUseCase _useCase;
  FavoritePageViewModel(this._useCase);
  final StreamController _favoriteStreamController =
      StreamController<FavoriteModel>();
  List<ProductResponseModel> _list = [];
  @override
  init() {
    super.init();
    getCart();
  }

  @override
  dispose() {
    _favoriteStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputFavorite => _favoriteStreamController.sink;

  @override
  Stream<FavoriteModel> get outputFavorite =>
      _favoriteStreamController.stream.map((event) => event);
  @override
  addToCart(int index) {
    // TODO: implement addToCart
    throw UnimplementedError();
  }

  @override
  getCart() async {
    inputState.add(LoadingState(
        type: StateRendererType.loadingFullScreenState,
        message: StringManager.loading));
    (await _useCase.execute(null)).fold((failure) {
      inputState.add(ErrorState(
          type: StateRendererType.errorFullScreenState,
          message: failure.message));
    }, (favoriteModel) {
      _list = favoriteModel.favorite;
      inputFavorite.add(favoriteModel);
    });
  }
}

abstract class FavoritePageViewModelInput {
  Sink get inputFavorite;
  getCart();
  addToCart(int index);
}

abstract class FavoritePageViewModelOutput {
  Stream<FavoriteModel> get outputFavorite;
}