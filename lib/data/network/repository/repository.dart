import 'package:dartz/dartz.dart';
import '../../../domain/model/authentication_model.dart';
import '../../../domain/model/home_model.dart';
import '../../../presentation/common/freezed_data/login_object.dart';
import '../../../presentation/common/freezed_data/register_object.dart';
import '../failure/failure.dart';

abstract class Repository {
  Future<Either<Failure, AuthenticationResponseModel>> login(LoginObject login);
  Future<Either<Failure, AuthenticationResponseModel>> register(
      RegisterObject register);
  Future<Either<Failure, HomeModel>> getHomeDetails();
}
