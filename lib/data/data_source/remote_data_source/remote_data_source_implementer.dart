import 'package:sneakers_shop/data/network/app_api/app_api.dart';

import 'remote_data_source.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);
}
