import 'package:dio/dio.dart';
import 'package:sneakers_shop/data/response/authentication_response.dart';
import 'package:sneakers_shop/data/response/cart_response.dart';
import 'package:sneakers_shop/data/response/favorite_response.dart';
import 'package:sneakers_shop/data/response/home_response.dart';
import 'package:sneakers_shop/data/response/settings_response.dart';

import '../../../app/app_constant.dart';
import 'app_api.dart';

class AppServiceClientImpl implements AppServiceClient {
  final Dio _dio;
  final String _baseUrl;
  AppServiceClientImpl(this._dio, {String baseUrl = AppConstants.baseUrl})
      : _baseUrl = baseUrl;

  @override
  Future<AuthenticationResponse> login(String email, String password) async {
    final data = {
      'email': email,
      'password': password,
    };
    final queryParameters = <String, dynamic>{};

    const extra = <String, dynamic>{};

    final headers = <String, dynamic>{};

    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthenticationResponse>(
            Options(method: "POST", headers: headers, extra: extra)
                .compose(_dio.options, "/api/login",
                    queryParameters: queryParameters, data: data)
                .copyWith(baseUrl: _baseUrl)));
    return AuthenticationResponse.fromJson(result.data!);
  }

  @override
  Future<AuthenticationResponse> register(
      String name, String email, String password) async {
    final data = {
      "name": name,
      'email': email,
      'password': password,
    };
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{};
    final extra = <String, dynamic>{};
    final result = await _dio.fetch<Map<String, dynamic>>(_setStreamType(
        Options(
      extra: extra,
      headers: headers,
      method: "POST",
    )
            .compose(_dio.options, "/api/register",
                queryParameters: queryParameters, data: data)
            .copyWith(baseUrl: _baseUrl)));
    return AuthenticationResponse.fromJson(result.data!);
  }

  @override
  Future<HomeResponse> home() async {
    final result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType(Options(
      method: "GET",
    ).compose(_dio.options, "/api/home").copyWith(baseUrl: _baseUrl)));
    return HomeResponse.fromJson(result.data!);
  }

  RequestOptions _setStreamType<T>(RequestOptions options) {
    if (T != dynamic &&
        !(options.responseType == ResponseType.bytes ||
            options.responseType == ResponseType.stream)) {
      if (T == String) {
        options.responseType = ResponseType.plain;
      } else {
        options.responseType = ResponseType.json;
      }
    }
    return options;
  }

  @override
  Future<CartResponse> getCart() async {
    final Map<String, dynamic> headers = {};
    final Map<String, dynamic> extra = {};
    final Map<String, dynamic> data = {};
    final response = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CartResponse>(
            Options(method: "GET", extra: extra, headers: headers)
                .compose(_dio.options, "/api/cart", data: data)
                .copyWith(baseUrl: _baseUrl)));
    return CartResponse.fromJson(response.data!);
  }

  @override
  Future<FavoriteResponse> getFavorites() async {
    final Map<String, dynamic> headers = {};
    final Map<String, dynamic> data = {};
    final Map<String, dynamic> extra = {};
    final Map<String, dynamic> queryParameters = {};
    final response = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FavoriteResponse>(
            Options(headers: headers, extra: extra, method: "GET")
                .compose(_dio.options, "/api/favorites",
                    data: data, queryParameters: queryParameters)
                .copyWith(baseUrl: _baseUrl)));
    return FavoriteResponse.fromJson(response.data!);
  }

  @override
  Future<SettingsResponse> getSettings() async {
    final Map<String, dynamic> headers = {};
    final Map<String, dynamic> extra = {};
    final response = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SettingsResponse>(
            Options(extra: extra, headers: headers, method: "GET")
                .compose(_dio.options, "/api/settings")
                .copyWith(baseUrl: _baseUrl)));
    return SettingsResponse.fromJson(response.data!);
  }
}
