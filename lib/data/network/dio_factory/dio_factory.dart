import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sneakers_shop/app/app_constant.dart';
import 'package:sneakers_shop/app/app_preferences.dart';

class DioFactory {
  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);
  Dio getDio()  {
    Dio dio = Dio();
    Map<String, dynamic> headers = {
      AppConstants.contentType: AppConstants.applicationJson,
      AppConstants.accept: AppConstants.applicationJson,
      AppConstants.authorization: "", //to-do
      
      AppConstants.languageKey: _appPreferences.getAppLanguage(),
    };
    dio.options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      headers: headers,
      sendTimeout: AppConstants.timeOut,
      connectTimeout: AppConstants.timeOut,
      receiveTimeout: AppConstants.timeOut,
      followRedirects: false,
    );

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
          return dio;

  }
}
