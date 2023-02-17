import 'package:dartz/dartz.dart';
import 'package:sneakers_shop/data/data_source/local_data_source/local_data_source.dart';
import 'package:sneakers_shop/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:sneakers_shop/data/mapper/authentication_mapper.dart';
import 'package:sneakers_shop/data/mapper/home_mapper.dart';
import 'package:sneakers_shop/data/network/error_handler/error_handler.dart';
import 'package:sneakers_shop/data/network/failure/failure.dart';
import 'package:sneakers_shop/data/network/network_info/network_info.dart';
import 'package:sneakers_shop/domain/model/home_model.dart';
import 'package:sneakers_shop/presentation/common/freezed_data/register_object.dart';
import 'package:sneakers_shop/presentation/common/freezed_data/login_object.dart';
import 'package:sneakers_shop/domain/model/authentication_model.dart';

import 'repository.dart';

class RepositoryImplementer implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final LocalDataSource _localDataSource;
  RepositoryImplementer(
      this._remoteDataSource, this._networkInfo, this._localDataSource);

  @override
  Future<Either<Failure, AuthenticationResponseModel>> login(
      LoginObject login) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(login);
        return Right(response.toModel());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, AuthenticationResponseModel>> register(
      RegisterObject register) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(register);
        return Right(response.toModel());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeModel>> getHomeDetails() async {
    try {
      final localResponse = await _localDataSource.getHomeResponse();
      return Right(localResponse.toModel());
    } catch (_) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.home();
          await _localDataSource.setHomeResponse(response);
          return Right(response.toModel());
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }
}
