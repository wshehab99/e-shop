import 'dart:async';

import '../../common/base_view_model/base_view_model.dart';

class SneakersDetailsViewModel extends BaseViewModel
    with SneakersDetailsViewModelInput, SneakersDetailsViewModelOutput {
  final StreamController _sizeStreamController =
      StreamController<List<SneakerSize>>();
  final StreamController _currencyStreamController =
      StreamController<List<Currency>>();
  final StreamController _validityStreamController = StreamController<bool>();
  final List<SneakerSize> _sizes = [
    SneakerSize(7.0),
    SneakerSize(7.5),
    SneakerSize(8.0),
    SneakerSize(8.5),
    SneakerSize(9.0),
    SneakerSize(9.5),
    SneakerSize(10.0)
  ];
  final List<Currency> _currencies = [Currency("US"), Currency("UK")];
//input
  @override
  Sink get inputCurrency => _currencyStreamController.sink;

  @override
  Sink get inputSize => _sizeStreamController.sink;
  @override
  Sink get inputAllValid => _validityStreamController.sink;

  //output
  @override
  Stream<List<Currency>> get outputCurrency =>
      _currencyStreamController.stream.map((event) => event);
  @override
  Stream<bool> get outputAllValid =>
      _validityStreamController.stream.map((_) => _checkValidation());
  @override
  Stream<List<SneakerSize>> get outputSize =>
      _sizeStreamController.stream.map((event) => event);
  @override
  dispose() {
    _currencyStreamController.close();
    _sizeStreamController.close();
    _validityStreamController.close();
  }

  @override
  init() {
    inputCurrency.add(_currencies);
    inputSize.add(_sizes);
  }

  @override
  setSelectedCurrency(int index) {
    _currencies.forEach((element) {
      element.isSelected = false;
    });
    _currencies.elementAt(index).isSelected = true;

    inputCurrency.add(_currencies);
    inputAllValid.add(true);
  }

  @override
  setSelectedSize(int index) {
    _sizes.forEach((element) {
      element.isSelected = false;
    });
    _sizes.elementAt(index).isSelected = true;

    inputSize.add(_sizes);
    inputAllValid.add(true);
  }

  bool _checkValidation() {
    bool currenciesValid = false;
    for (int i = 0; i < _currencies.length; i++) {
      if (_currencies[i].isSelected) {
        currenciesValid = true;
        break;
      }
    }
    bool sizeValid = false;
    for (int i = 0; i < _sizes.length; i++) {
      if (_sizes[i].isSelected) {
        sizeValid = true;
        break;
      }
    }
    return currenciesValid && sizeValid;
  }
}

abstract class SneakersDetailsViewModelInput {
  Sink get inputCurrency;
  Sink get inputSize;
  Sink get inputAllValid;
  setSelectedCurrency(int index);
  setSelectedSize(int index);
}

abstract class SneakersDetailsViewModelOutput {
  Stream<List<Currency>> get outputCurrency;
  Stream<List<SneakerSize>> get outputSize;
  Stream<bool> get outputAllValid;
}

class Currency {
  String currency;
  bool isSelected;
  Currency(this.currency, {this.isSelected = false});
}

class SneakerSize {
  double size;
  bool isSelected;
  SneakerSize(this.size, {this.isSelected = false});
}
