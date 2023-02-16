import 'package:sneakers_shop/app/app_constant.dart';
import '../../domain/model/authentication_model.dart';
import '../response/authentication_response.dart';
import '../response/contact_response.dart';

extension AuthenticationResponseExtension on AuthenticationResponse? {
  AuthenticationResponseModel toModel() {
    return AuthenticationResponseModel(
      this?.status ?? 0,
      this?.message ?? AppConstants.empty,
      this?.contact.toModel() ?? ContactResponseModel.empty(),
    );
  }
}

extension ContactResponseExtension on ContactResponse? {
  ContactResponseModel toModel() {
    return ContactResponseModel(this?.name ?? AppConstants.empty,
        this?.phone ?? AppConstants.empty, this?.email ?? AppConstants.empty);
  }
}
