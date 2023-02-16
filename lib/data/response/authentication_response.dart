import 'base_response.dart';
import 'contact_response.dart';

class AuthenticationResponse extends BaseResponse {
  ContactResponse? contact;
  AuthenticationResponse(super.status, super.message, this.contact);
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      AuthenticationResponse(json["status"] as int?, json["message"] as String?,
          ContactResponse.fromJson(json["contact"]));
  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        "status": super.status,
        "message": super.message,
        "contact": contact,
      };
}
