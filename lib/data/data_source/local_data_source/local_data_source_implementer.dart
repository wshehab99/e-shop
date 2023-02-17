import '../../../app/app_constant.dart';
import '../../network/error_handler/error_handler.dart';
import '../../response/home_response.dart';
import 'cached_data.dart';
import 'local_data_source.dart';

class LocalDataSourceImplementer implements LocalDataSource {
  Map<String, CachedData> data = {};

  @override
  Future<HomeResponse> getHomeResponse() {
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
}
