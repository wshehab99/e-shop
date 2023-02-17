import 'package:dio/dio.dart';

import '../../../presentation/resources/string_manager.dart';
import '../failure/failure.dart';
import '../../../app/app_extensions.dart';

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(error) {
    if (error is DioError) {
      failure = _handleError(error);
    } else {
      failure = DataSource.unknown.getFailure();
    }
  }
  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.connectTimeout.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioErrorType.response:
        if (error.response != null) {
          return Failure(
              code: error.response!.statusCode.orZero(),
              message: error.response!.statusMessage.orEmpty());
        }
        return DataSource.connectTimeout.getFailure();
      case DioErrorType.cancel:
        return DataSource.cancelled.getFailure();
      case DioErrorType.other:
        return DataSource.unknown.getFailure();
    }
  }
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancelled,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  unknown
}

abstract class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unauthorized = 401; // failure, user is not authorized
  static const int forbidden = 403; //  failure, API rejected request
  static const int internalServerError = 500; // failure, crash in server side
  static const int notFound = 404;
  // local status code
  static const int connectTimeout = -1; //
  static const int cancelled = -2; //
  static const int receiveTimeout = -3; //
  static const int sendTimeout = -4; //
  static const int cacheError = -5; //
  static const int noInternetConnection = -6; //
  static const int unknown = -7; //
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(
            code: ResponseCode.success, message: StringManager.success);
      case DataSource.noContent:
        return Failure(
            code: ResponseCode.noContent, message: StringManager.noContent);

      case DataSource.badRequest:
        return Failure(
            code: ResponseCode.badRequest, message: StringManager.badRequest);

      case DataSource.forbidden:
        return Failure(
            code: ResponseCode.forbidden, message: StringManager.forbidden);

      case DataSource.unauthorized:
        return Failure(
            code: ResponseCode.unauthorized,
            message: StringManager.unauthorized);

      case DataSource.notFound:
        return Failure(
            code: ResponseCode.notFound, message: StringManager.notFound);

      case DataSource.internalServerError:
        return Failure(
            code: ResponseCode.internalServerError,
            message: StringManager.internalServerError);

      case DataSource.connectTimeout:
        return Failure(
            code: ResponseCode.connectTimeout,
            message: StringManager.connectTimeout);

      case DataSource.cancelled:
        return Failure(
            code: ResponseCode.cancelled, message: StringManager.cancelled);

      case DataSource.receiveTimeout:
        return Failure(
            code: ResponseCode.receiveTimeout,
            message: StringManager.receiveTimeout);

      case DataSource.sendTimeout:
        return Failure(
            code: ResponseCode.sendTimeout, message: StringManager.sendTimeout);

      case DataSource.cacheError:
        return Failure(
            code: ResponseCode.cacheError, message: StringManager.cacheError);

      case DataSource.noInternetConnection:
        return Failure(
            code: ResponseCode.noInternetConnection,
            message: StringManager.noInternetConnection);

      case DataSource.unknown:
        return Failure(
            code: ResponseCode.unknown, message: StringManager.unknown);
    }
  }
}
