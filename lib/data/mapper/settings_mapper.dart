import 'package:sneakers_shop/app/app_constant.dart';
import 'package:sneakers_shop/data/mapper/authentication_mapper.dart';
import 'package:sneakers_shop/data/mapper/home_mapper.dart';
import 'package:sneakers_shop/domain/model/authentication_model.dart';
import 'package:sneakers_shop/domain/model/home_model.dart';
import 'package:sneakers_shop/domain/model/settings_model.dart';

import '../response/settings_response.dart';

extension SettingsResponseExtension on SettingsResponse? {
  SettingsModel toModel() {
    final List<AchievementModelResponse> achievement =
        this?.data?.achievement?.map((element) => element.toModel()).toList() ??
            const Iterable.empty().cast<AchievementModelResponse>().toList();
    final List<AchievementModelResponse> newAchievement = this
            ?.data
            ?.newAchievement
            ?.map((element) => element.toModel())
            .toList() ??
        const Iterable.empty().cast<AchievementModelResponse>().toList();
    final List<PaymentModelResponse> payment =
        this?.data?.payment?.map((element) => element.toModel()).toList() ??
            const Iterable.empty().cast<PaymentModelResponse>().toList();
    final List<PaymentModelResponse> newPayment =
        this?.data?.newPayment?.map((element) => element.toModel()).toList() ??
            const Iterable.empty().cast<PaymentModelResponse>().toList();
    final List<PrivacyModelResponse> privacy =
        this?.data?.privacy?.map((element) => element.toModel()).toList() ??
            const Iterable.empty().cast<PrivacyModelResponse>().toList();

    final SettingsDataModelResponse data = SettingsDataModelResponse(
        this?.data?.contact?.toModel() ?? ContactResponseModel.empty(),
        newPayment,
        payment,
        newAchievement,
        achievement,
        privacy);
    return SettingsModel(data);
  }
}

extension AchievementResponseExtension on AchievementResponse? {
  AchievementModelResponse toModel() =>
      AchievementModelResponse(this?.action ?? AppConstants.empty);
}

extension PaymentResponseExtension on PaymentResponse? {
  PaymentModelResponse toModel() => PaymentModelResponse(
      this?.product?.toModel() ?? ProductResponseModel.empty(),
      this?.payed ?? false);
}

extension PrivacyResponseExtension on PrivacyResponse? {
  PrivacyModelResponse toModel() =>
      PrivacyModelResponse(this?.action ?? AppConstants.empty);
}
