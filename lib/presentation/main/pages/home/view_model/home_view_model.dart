import 'dart:async';

import '../../../../../domain/model/home_model.dart';
import '../../../../common/base_view_model/base_view_model.dart';
import '../../../../../domain/use_cases/home_use_case.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../resources/string_manager.dart';

class HomeViewMode1 extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final StreamController _selectedIndexStreamController =
      StreamController<int>();
  final StreamController _selectedListStreamController =
      StreamController<List<ProductResponseModel>>();

  final StreamController _moreListStreamController =
      StreamController<List<ProductResponseModel>>();
  final HomeUseCase _useCase;
  HomeViewMode1(this._useCase);
  late List<List<ProductResponseModel>> _list;

  @override
  Sink get inputSelectedIndex => _selectedIndexStreamController.sink;
  @override
  Sink get inputSelectedList => _selectedListStreamController.sink;
  @override
  Sink get inputMoreList => _moreListStreamController.sink;

  @override
  Stream<List<ProductResponseModel>> get outputMoreList =>
      _moreListStreamController.stream.map((list) => list);
  @override
  Stream<List<ProductResponseModel>> get outputShownList =>
      _selectedListStreamController.stream.map((list) => list);
  @override
  Stream<int> get outputSelectedIndex =>
      _selectedIndexStreamController.stream.map((index) => index);
  @override
  init() {
    super.init();
    inputSelectedIndex.add(0);
    getFeed();
  }

  @override
  dispose() {
    _selectedListStreamController.close();
    _selectedIndexStreamController.close();
    _moreListStreamController.close();
    super.dispose();
  }

  @override
  getFeed() async {
    inputState.add(LoadingState(
        type: StateRendererType.loadingFullScreenState,
        message: StringManager.loading));
    (await _useCase.execute(null)).fold((failure) {
      inputState.add(ErrorState(
          type: StateRendererType.errorFullScreenState,
          message: failure.message));
    }, (homeModel) {
      _list.add(homeModel.data.upcoming);
      _list.add(homeModel.data.featured);
      _list.add(homeModel.data.news);
      inputMoreList.add(homeModel.data.more);
      inputState.add(ContentState());
    });
  }

  @override
  changeIndex(int index) {
    inputSelectedIndex.add(index);
    if (index < _list.length) {
      inputSelectedList.add(_list[index]);
    }
  }
}

abstract class HomeViewModelInput {
  Sink get inputSelectedIndex;
  Sink get inputSelectedList;
  Sink get inputMoreList;

  getFeed();
  changeIndex(int index);
}

abstract class HomeViewModelOutput {
  Stream<int> get outputSelectedIndex;
  Stream<List<ProductResponseModel>> get outputShownList;
  Stream<List<ProductResponseModel>> get outputMoreList;
}
