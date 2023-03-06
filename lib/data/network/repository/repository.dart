import 'package:dartz/dartz.dart';
import 'package:sneakers_shop/domain/model/favorite_model.dart';
import '../../../domain/model/authentication_model.dart';
import '../../../domain/model/cart_model.dart';
import '../../../domain/model/home_model.dart';
import '../../../domain/model/settings_model.dart';
import '../../../presentation/common/freezed_data/login_object.dart';
import '../../../presentation/common/freezed_data/register_object.dart';
import '../failure/failure.dart';

abstract class Repository {
  Future<Either<Failure, AuthenticationResponseModel>> login(LoginObject login);
  Future<Either<Failure, AuthenticationResponseModel>> register(
      RegisterObject register);
  Future<Either<Failure, HomeModel>> getHomeDetails();
  Future<Either<Failure, CartModel>> getCart();
  Future<void> setCart(CartModel cart);
  Future<Either<Failure, FavoriteModel>> getFavorite();
  Future<Either<Failure, SettingsModel>> getSettings();
}
