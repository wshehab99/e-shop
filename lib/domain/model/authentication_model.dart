class AuthenticationResponseModel extends BaseResponseModel {
  ContactResponseModel contact;

  AuthenticationResponseModel(super.status, super.message, this.contact);
}

class ContactResponseModel {
  String name;
  String phone;
  String email;
  ContactResponseModel(this.name, this.phone, this.email);
  factory ContactResponseModel.empty() {
    return ContactResponseModel("", "", "");
  }
}

class BaseResponseModel {
  int status;
  String message;
  BaseResponseModel(this.status, this.message);
}
