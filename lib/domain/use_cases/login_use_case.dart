import 'package:sneakers_shop/data/network/failure/failure.dart';

import 'package:dartz/dartz.dart';

import '../../data/network/repository/repository.dart';
import '../../presentation/common/freezed_data/login_object.dart';
import '../model/authentication_model.dart';
import 'base_use_case.dart';

class LoginUseCase
    implements BaseUseCase<LoginObject, AuthenticationResponseModel> {
  final Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, AuthenticationResponseModel>> execute(
      LoginObject input) {
    return _repository.login(input);
  }
}
