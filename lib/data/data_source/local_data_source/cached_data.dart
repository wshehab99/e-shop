import '../../../app/app_constant.dart';

class CachedData {
  dynamic data;
  int cachedTime = DateTime.now().millisecondsSinceEpoch;
  CachedData(this.data);
}

extension CachedDataExtension on CachedData {
  bool isValid() {
    return DateTime.now().millisecondsSinceEpoch - cachedTime <=
        AppConstants.cacheTimeOut;
  }
}
