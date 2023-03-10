import 'package:dartz/dartz.dart';
import 'package:sneakers_shop/data/data_source/local_data_source/local_data_source.dart';
import 'package:sneakers_shop/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:sneakers_shop/data/mapper/authentication_mapper.dart';
import 'package:sneakers_shop/data/mapper/cart_mapper.dart';
import 'package:sneakers_shop/data/mapper/favorite_mapper.dart';
import 'package:sneakers_shop/data/mapper/home_mapper.dart';
import 'package:sneakers_shop/data/mapper/settings_mapper.dart';
import 'package:sneakers_shop/data/network/error_handler/error_handler.dart';
import 'package:sneakers_shop/data/network/failure/failure.dart';
import 'package:sneakers_shop/data/network/network_info/network_info.dart';
import 'package:sneakers_shop/domain/model/favorite_model.dart';
import 'package:sneakers_shop/domain/model/home_model.dart';
import 'package:sneakers_shop/domain/model/settings_model.dart';
import 'package:sneakers_shop/presentation/common/freezed_data/register_object.dart';
import 'package:sneakers_shop/presentation/common/freezed_data/login_object.dart';
import 'package:sneakers_shop/domain/model/authentication_model.dart';

import '../../../domain/model/cart_model.dart';
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

  @override
  Future<Either<Failure, CartModel>> getCart() async {
    try {
      final localResponse = await _localDataSource.getCartResponse();
      return Right(localResponse.toModel());
    } catch (_) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getCart();
          await _localDataSource.setCartResponse(response);
          return Right(response.toModel());
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, FavoriteModel>> getFavorite() async {
    try {
      final localResponse = await _localDataSource.getFavoriteResponse();
      return Right(localResponse.toModel());
    } catch (_) {
      if (await _networkInfo.isConnected) {
        final response = await _remoteDataSource.getFavorite();
        await _localDataSource.setFavoriteResponse(response);
        return Right(response.toModel());
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, SettingsModel>> getSettings() async {
    try {
      final localResponse = await _localDataSource.getSettingsResponse();
      return Right(localResponse.toModel());
    } catch (_) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getSettings();
          await _localDataSource.setSettingsResponse(response);
          return Right(response.toModel());
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }

  @override
  Future<void> setCart(CartModel cart)async {
 return await  _localDataSource.setCartResponse(cart.toResponse());
  }
}
