import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../base_view_model/base_view_model.dart';

class MainViewModel extends BaseViewModel
    with MainViewModelInput, MainViewModelOutput {
  final StreamController<int> _currentIndexStreamController =
      BehaviorSubject<int>();
  // inputs
  @override
  Sink get inputCurrentIndex => _currentIndexStreamController.sink;
  //outputs
  @override
  Stream<int> get outputCurrentIndex =>
      _currentIndexStreamController.stream.map((index) => index);

  @override
  dispose() {
    _currentIndexStreamController.close();
    super.dispose();
  }

  @override
  init() {
    inputCurrentIndex.add(0);
    super.init();
  }

  @override
  setCurrentIndex(index) {
    inputCurrentIndex.add(index);
  }
}

abstract class MainViewModelInput {
  Sink get inputCurrentIndex;
  setCurrentIndex(index);
}

abstract class MainViewModelOutput {
  Stream<int> get outputCurrentIndex;
}
