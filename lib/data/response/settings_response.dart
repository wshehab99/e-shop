import 'package:sneakers_shop/data/response/contact_response.dart';
import 'package:sneakers_shop/data/response/product_response.dart';

import 'base_response.dart';

class SettingsResponse extends BaseResponse {
  SettingsDataResponse? data;

  SettingsResponse(super.status, super.message, this.data);
  factory SettingsResponse.fromJson(Map<String, dynamic> json) =>
      SettingsResponse(
        json["status"] as int?,
        json["message"] as String?,
        SettingsDataResponse.fromJson(json["data"]),
      );
}

class SettingsDataResponse {
  ContactResponse? contact;
  List<PaymentResponse>? payment;
  List<PaymentResponse>? newPayment;
  List<AchievementResponse>? achievement;
  List<AchievementResponse>? newAchievement;
  List<PrivacyResponse>? privacy;
  SettingsDataResponse(this.contact, this.newPayment, this.payment,
      this.newAchievement, this.achievement, this.privacy);
  factory SettingsDataResponse.fromJson(Map<String, dynamic> json) =>
      SettingsDataResponse(
          ContactResponse.fromJson(json["contact"]),
          (json["newPayment"] as List<dynamic>)
              .map((element) =>
                  PaymentResponse.fromJson(element as Map<String, dynamic>))
              .toList(),
          (json["payment"] as List<dynamic>)
              .map((element) =>
                  PaymentResponse.fromJson(element as Map<String, dynamic>))
              .toList(),
          (json["newAchievement"] as List<dynamic>)
              .map((element) =>
                  AchievementResponse.fromJson(element as Map<String, dynamic>))
              .toList(),
          (json["achievement"] as List<dynamic>)
              .map((element) =>
                  AchievementResponse.fromJson(element as Map<String, dynamic>))
              .toList(),
          (json["privacy"] as List<dynamic>)
              .map((element) =>
                  PrivacyResponse.fromJson(element as Map<String, dynamic>))
              .toList());
}

class PaymentResponse {
  ProductResponse? product;
  bool? payed;
  PaymentResponse(this.product, this.payed);
  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      PaymentResponse(
          ProductResponse.fromJson(json["product"]), json['is_payed'] as bool?);
}

class AchievementResponse {
  String? action;
  AchievementResponse(this.action);
  factory AchievementResponse.fromJson(Map<String, dynamic> json) =>
      AchievementResponse(json["action"] as String?);
}

class PrivacyResponse {
  String? action;
  PrivacyResponse(this.action);
  factory PrivacyResponse.fromJson(Map<String, dynamic> json) =>
      PrivacyResponse(json["action"] as String?);
}
