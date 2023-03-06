import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sneakers_shop/domain/model/favorite_model.dart';
import 'package:sneakers_shop/domain/use_cases/favorite_use_case.dart';
import 'package:sneakers_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:sneakers_shop/presentation/resources/string_manager.dart';

import '../../../../base_view_model/base_view_model.dart';

class FavoritePageViewModel extends BaseViewModel
    with FavoritePageViewModelInput, FavoritePageViewModelOutput {
  final FavoriteUseCase _useCase;
  FavoritePageViewModel(this._useCase);
  final StreamController _favoriteStreamController =
      BehaviorSubject<FavoriteModel>();
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
  addToCart(int index) {}

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
      inputFavorite.add(favoriteModel);
      inputState.add(ContentState());
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
