import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sneakers_shop/domain/model/home_model.dart';
import 'package:sneakers_shop/domain/use_cases/cart_use_case.dart';
import 'package:sneakers_shop/presentation/base_view_model/base_view_model.dart';
import 'package:sneakers_shop/presentation/common/state_renderer/state_renderer.dart';
import 'package:sneakers_shop/presentation/resources/string_manager.dart';

import '../../../../../domain/model/bag_model.dart';

class CartPageViewModel extends BaseViewModel
    with CartPageViewModelInput, CartPageViewModelOutput {
  final StreamController _bagItemStreamController =
      BehaviorSubject<List<BagItem>>();
  final StreamController _totalPriceStreamController =
      BehaviorSubject<double>();
  List<BagItem> _list = [];
  final CartUseCase _useCase;
  CartPageViewModel(this._useCase);
  //input
  @override
  Sink get inputBagItem => _bagItemStreamController.sink;

  @override
  Sink get inputTotalPrice => _totalPriceStreamController.sink;

  @override
  Stream<double> get outputTotalPrice =>
      _totalPriceStreamController.stream.map((_) => _getTotalPrice());
  @override
  Stream<List<BagItem>> get outputBagItem =>
      _bagItemStreamController.stream.map((list) => list);
  @override
  dispose()async {
    _bagItemStreamController.close();
    _totalPriceStreamController.close();
    super.dispose();
  }

  @override
  init() {
    super.init();
    inputBagItem.add(_list);
    inputTotalPrice.add(_getTotalPrice());
    getCart();
  }

  @override
  void decreaseItemNumber(index) {
    if (_list.elementAt(index).numberOfItems > 0) {
      _list.elementAt(index).numberOfItems--;
      inputBagItem.add(_list);
      inputTotalPrice.add(_getTotalPrice());
    }
  }

  @override
  void increaseItemNumber(index) {
    _list.elementAt(index).numberOfItems++;
    inputBagItem.add(_list);
    inputTotalPrice.add(_getTotalPrice());
  }

  _getTotalPrice() {
    double totalPrice = 0;
    for (int i = 0; i < _list.length; i++) {
      totalPrice += _list[i].product.price * _list[i].numberOfItems;
    }
    return totalPrice;
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
    }, (cartModel) {
      _changeToBag(cartModel.cart);
      inputState.add(ContentState());
    });
  }

  _changeToBag(List<ProductResponseModel> cart) {
    _list = cart.map((element) => element.toBag()).toList();
    inputBagItem.add(_list);
  }
}

abstract class CartPageViewModelInput {
  Sink get inputBagItem;
  Sink get inputTotalPrice;
  void increaseItemNumber(index);
  void decreaseItemNumber(index);
  getCart();
}

abstract class CartPageViewModelOutput {
  Stream<List<BagItem>> get outputBagItem;
  Stream<double> get outputTotalPrice;
}
