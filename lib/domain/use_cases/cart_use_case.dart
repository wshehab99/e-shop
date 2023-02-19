import 'package:sneakers_shop/data/network/failure/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:sneakers_shop/data/network/repository/repository.dart';

import '../model/cart_model.dart';
import 'base_use_case.dart';

class CartUseCase extends BaseUseCase<void,CartModel> {
  final Repository _repository;
  CartUseCase(this._repository);
  
  @override
  Future<Either<Failure, CartModel>> execute(void input) {
    return _repository.getCart();
  }

}
