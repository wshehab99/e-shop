import 'package:dio/dio.dart';
import 'package:sneakers_shop/data/response/favorite_response.dart';
import 'package:sneakers_shop/data/response/settings_response.dart';
import '../../response/authentication_response.dart';
import '../../response/cart_response.dart';
import '../../response/home_response.dart';
import 'app_api_implementer.dart';

abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = AppServiceClientImpl;
  Future<AuthenticationResponse> login(String email, String password);
  Future<AuthenticationResponse> register(
      String name, String email, String password);
  Future<HomeResponse> home();
  Future<CartResponse> getCart();
  Future<FavoriteResponse> getFavorites();
  Future<SettingsResponse> getSettings();
}
