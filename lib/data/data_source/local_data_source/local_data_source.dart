import 'package:sneakers_shop/data/response/home_response.dart';
import 'package:sneakers_shop/data/response/settings_response.dart';

import '../../response/cart_response.dart';
import '../../response/favorite_response.dart';

abstract class LocalDataSource {
  Future<HomeResponse> getHomeResponse();
  Future<void> setHomeResponse(HomeResponse response);
  Future<CartResponse> getCartResponse();
  Future<void> setCartResponse(CartResponse response);
  Future<FavoriteResponse> getFavoriteResponse();

  Future<void> setFavoriteResponse(FavoriteResponse response);
  Future<SettingsResponse> getSettingsResponse();

  Future<void> setSettingsResponse(SettingsResponse response);
}
