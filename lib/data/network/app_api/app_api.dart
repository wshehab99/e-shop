import 'package:dio/dio.dart';
import 'app_api_implementer.dart';

abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = AppServiceClientImpl;
}
