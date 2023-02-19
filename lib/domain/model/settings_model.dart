import 'package:sneakers_shop/domain/model/authentication_model.dart';
import 'package:sneakers_shop/domain/model/home_model.dart';

class SettingsModel {
  SettingsDataModelResponse data;

  SettingsModel(this.data);
}

class SettingsDataModelResponse {
  ContactResponseModel contact;
  List<PaymentModelResponse> payment;
  List<PaymentModelResponse> newPayment;
  List<AchievementModelResponse> achievement;
  List<AchievementModelResponse> newAchievement;
  List<PrivacyModelResponse> privacy;
  SettingsDataModelResponse(this.contact, this.newPayment, this.payment,
      this.newAchievement, this.achievement, this.privacy);
}

class PaymentModelResponse {
  ProductResponseModel product;
  bool payed;
  PaymentModelResponse(this.product, this.payed);
}

class AchievementModelResponse {
  String action;
  AchievementModelResponse(this.action);
}

class PrivacyModelResponse {
  String action;
  PrivacyModelResponse(this.action);
}
