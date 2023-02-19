import 'package:sneakers_shop/data/network/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:sneakers_shop/data/network/repository/repository.dart';
import 'package:sneakers_shop/domain/model/favorite_model.dart';

import 'base_use_case.dart';

class FavoriteUseCase extends BaseUseCase<void, FavoriteModel> {
  final Repository _repository;
  FavoriteUseCase(this._repository);
  @override
  Future<Either<Failure, FavoriteModel>> execute(void input) {
    return _repository.getFavorite();
  }
}
