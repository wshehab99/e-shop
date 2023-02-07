import 'package:dio/dio.dart';

import '../../../app/app_constant.dart';
import 'app_api.dart';

class AppServiceClientImpl implements AppServiceClient {
  final Dio dio;
  final String baseUrl;
  AppServiceClientImpl(this.dio, {this.baseUrl = AppConstants.baseUrl});
}
