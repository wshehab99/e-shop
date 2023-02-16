import 'package:sneakers_shop/data/network/failure/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:sneakers_shop/data/network/repository/repository.dart';

import '../../presentation/common/freezed_data/register_object.dart';
import '../model/authentication_model.dart';
import 'base_use_case.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterObject, AuthenticationResponseModel> {
  final Repository _repository;
  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, AuthenticationResponseModel>> execute(
      RegisterObject input) {
    return _repository.register(input);
  }
}
