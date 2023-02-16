import 'package:sneakers_shop/data/network/app_api/app_api.dart';
import 'package:sneakers_shop/data/response/home_response.dart';
import 'package:sneakers_shop/presentation/common/freezed_data/login_object.dart';
import 'package:sneakers_shop/data/response/authentication_response.dart';
import 'package:sneakers_shop/presentation/common/freezed_data/register_object.dart';
import 'remote_data_source.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginObject login) {
    return _appServiceClient.login(login.username, login.password);
  }

  @override
  Future<AuthenticationResponse> register(RegisterObject register) {
    return _appServiceClient.register(
        register.name, register.username, register.password);
  }

  @override
  Future<HomeResponse> home() {
    return _appServiceClient.home();
  }
}
