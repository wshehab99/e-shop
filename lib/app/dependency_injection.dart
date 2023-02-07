import 'package:get_it/get_it.dart';
import 'package:sneakers_shop/presentation/onboarding/view_model/onboarding_view_model.dart';

class DependencyInjection {
  static GetIt instance = GetIt.instance;
  static initOnboarding() {
    if (!instance.isRegistered<OnboardingViewModel>()) {
      instance
          .registerFactory<OnboardingViewModel>(() => OnboardingViewModel());
    }
  }
}
