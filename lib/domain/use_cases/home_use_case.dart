import 'package:dartz/dartz.dart';
import 'package:sneakers_shop/data/network/failure/failure.dart';
import 'package:sneakers_shop/data/network/repository/repository.dart';
import 'package:sneakers_shop/domain/model/home_model.dart';

import 'base_use_case.dart';

class HomeUseCase extends BaseUseCase<void, HomeModel> {
  final Repository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeModel>> execute(void input) {
    return _repository.getHomeDetails();
  }
}
