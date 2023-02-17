import 'package:sneakers_shop/data/response/home_response.dart';

abstract class LocalDataSource {
  Future<HomeResponse> getHomeResponse();
  Future<void> setHomeResponse(HomeResponse response);
}
