import 'package:sneakers_shop/data/response/cart_response.dart';
import 'package:sneakers_shop/data/response/favorite_response.dart';
import 'package:sneakers_shop/data/response/settings_response.dart';

import '../../../app/app_constant.dart';
import '../../network/error_handler/error_handler.dart';
import '../../response/home_response.dart';
import 'cached_data.dart';
import 'local_data_source.dart';

class LocalDataSourceImplementer implements LocalDataSource {
  Map data = <String, CachedData>{};

  @override
  Future<HomeResponse> getHomeResponse() async {
    CachedData? cachedItem = data[AppConstants.cachedHomeResponse];
    if (cachedItem != null && cachedItem.isValid()) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> setHomeResponse(HomeResponse response) async {
    data[AppConstants.cachedHomeResponse] = CachedData(response);
  }

  @override
  Future<void> setCartResponse(CartResponse response) async {
    data[AppConstants.cachedCartResponse] = CachedData(response);
  }

  @override
  Future<CartResponse> getCartResponse() async {
    CachedData? cachedItem = data[AppConstants.cachedCartResponse];
    if (cachedItem != null && cachedItem.isValid()) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<FavoriteResponse> getFavoriteResponse() async {
    CachedData? cachedItem = data[AppConstants.cachedFavoriteResponse];
    if (cachedItem != null && cachedItem.isValid()) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> setFavoriteResponse(FavoriteResponse response) async {
    data[AppConstants.cachedFavoriteResponse] = CachedData(response);
  }

  @override
  Future<SettingsResponse> getSettingsResponse() async {
    CachedData? cachedItem = data[AppConstants.cachedSettingsResponse];
    if (cachedItem != null && cachedItem.isValid()) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> setSettingsResponse(SettingsResponse response) async {
    data[AppConstants.cachedSettingsResponse] = CachedData(response);
  }
}
