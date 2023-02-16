import '../../../presentation/common/freezed_data/login_object.dart';
import '../../../presentation/common/freezed_data/register_object.dart';
import '../../response/authentication_response.dart';
import '../../response/home_response.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginObject login);
  Future<AuthenticationResponse> register(RegisterObject register);
  Future<HomeResponse> home();
}
