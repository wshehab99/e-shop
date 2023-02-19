import 'package:sneakers_shop/app/app_constant.dart';

class AuthenticationResponseModel extends BaseResponseModel {
  ContactResponseModel contact;

  AuthenticationResponseModel(super.status, super.message, this.contact);
}

class ContactResponseModel {
  String name;
  String phone;
  String email;
  String imgUrl;
  ContactResponseModel(this.name, this.phone, this.email, this.imgUrl);
  factory ContactResponseModel.empty() {
    return ContactResponseModel(AppConstants.empty, AppConstants.empty,
        AppConstants.empty, AppConstants.empty);
  }
}

class BaseResponseModel {
  int status;
  String message;
  BaseResponseModel(this.status, this.message);
}
