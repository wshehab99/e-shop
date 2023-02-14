import 'package:sneakers_shop/data/data_source/local_data_source/local_data_source.dart';
import 'package:sneakers_shop/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:sneakers_shop/data/network/network_info/network_info.dart';

import 'repository.dart';

class RepositoryImplementer implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final LocalDataSource _localDataSource;
  RepositoryImplementer(
      this._remoteDataSource, this._networkInfo, this._localDataSource);
}
