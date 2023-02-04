import 'dart:async';

import 'package:sneakers_shop/presentation/common/base_view_model/base_view_model.dart';

import '../../../../resources/asset_manager.dart';
import '../../../../resources/string_manager.dart';

class CartPageViewModel extends BaseViewModel
    with CartPageViewModelInput, CartPageViewModelOutput {
  final StreamController _bagItemStreamController =
      StreamController<List<BagItem>>();
  final StreamController _totalPriceStreamController =
      StreamController<double>();
  final List<BagItem> _list = [
    BagItem(
      "${StringManager.nike} - ${StringManager.airMax}",
      150.75,
      AssetImageManager.nike1,
      1,
    ),
    BagItem(
      "${StringManager.nike} - ${StringManager.airMax}",
      114.99,
      AssetImageManager.nike1,
      5,
    ),
  ];
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
  dispose() {
    _bagItemStreamController.close();
    _totalPriceStreamController.close();
  }

  @override
  init() {
    inputBagItem.add(_list);
    inputTotalPrice.add(_getTotalPrice());
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
      totalPrice += _list[i].itemPrice * _list[i].numberOfItems;
    }
    return totalPrice;
  }
}

abstract class CartPageViewModelInput {
  Sink get inputBagItem;
  Sink get inputTotalPrice;
  void increaseItemNumber(index);
  void decreaseItemNumber(index);
}

abstract class CartPageViewModelOutput {
  Stream<List<BagItem>> get outputBagItem;
  Stream<double> get outputTotalPrice;
}

class BagItem {
  int numberOfItems;
  String itemName;
  String itemImageUrl;
  double itemPrice;
  BagItem(this.itemName, this.itemPrice, this.itemImageUrl, this.numberOfItems);
}
