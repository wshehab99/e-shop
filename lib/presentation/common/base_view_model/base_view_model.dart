import 'dart:async';

import 'package:sneakers_shop/app/app_constant.dart';
import 'package:sneakers_shop/presentation/common/state_renderer/state_renderer.dart';

abstract class BaseViewModel extends BaseViewModelInput
    with BaseViewModelOutput {
  final StreamController _stateStreamController = StreamController<FlowState>();
  @override
  Sink get inputState => _stateStreamController.sink;
  @override
  Stream<FlowState> get outputState =>
      _stateStreamController.stream.map((state) => state);
  @override
  dispose() {
    _stateStreamController.close();
  }

  @override
  init() {
    inputState.add(ContentState(
        type: StateRendererType.contentState, message: AppConstants.empty));
  }
}

abstract class BaseViewModelInput {
  init();
  dispose();
  Sink get inputState;
}

abstract class BaseViewModelOutput {
  Stream<FlowState> get outputState;
}
