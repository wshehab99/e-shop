import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../../../../domain/model/home_model.dart';
import '../../../../common/base_view_model/base_view_model.dart';
import '../../../../../domain/use_cases/home_use_case.dart';
import '../../../../common/state_renderer/state_renderer.dart';
import '../../../../resources/string_manager.dart';

class HomeViewMode1 extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final StreamController _selectedIndexStreamController =
      BehaviorSubject<int>();
  final StreamController _selectedListStreamController =
      BehaviorSubject<List<ProductResponseModel>>();

  final StreamController _moreListStreamController =
      BehaviorSubject<List<ProductResponseModel>>();
  final HomeUseCase _useCase;
  HomeViewMode1(this._useCase);
  final HomeObject _object = HomeObject([], [], []);

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
  init() async {
    inputSelectedIndex.add(0);
    await getFeed();
    return super.init();
  }

  @override
  dispose() {
    _selectedListStreamController.close();
    _selectedIndexStreamController.close();
    _moreListStreamController.close();
    return super.dispose();
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
      inputState.add(ContentState());
      _insertData(homeModel.data);
    });
  }

  @override
  changeIndex(int index) {
    if (index == 0) {
      inputSelectedList.add(_object.upcoming);
    } else if (index == 1) {
      inputSelectedList.add(_object.featured);
    } else {
      inputSelectedList.add(_object.news);
    }
    inputSelectedIndex.add(index);
  }

  void _insertData(HomeDataResponseModel data) {
    _object.featured = data.featured;
    _object.news = data.news;
    _object.upcoming = data.upcoming;
    inputMoreList.add(data.more);
    changeIndex(0);
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

class HomeObject {
  List<ProductResponseModel> upcoming;
  List<ProductResponseModel> featured;
  List<ProductResponseModel> news;
  HomeObject(this.upcoming, this.featured, this.news);
}
