import 'package:flutter/material.dart';
import 'package:sneakers_shop/domain/model/derails_object.dart';
import '../../app/dependency_injection.dart';
import '../forget_password/forget_password.dart';
import '../login/view/login_view.dart';
import '../main/view/main_page.dart';
import '../notifications/notifications.dart';
import '../onboarding/view/onboarding_view.dart';
import '../register/view/register_view.dart';
import '../search/search_view.dart';
import '../sneaker_details/view/sneaker_details_view.dart';
import '../splash/splash_view.dart';
import 'string_manager.dart';

abstract class RouteManager {
  static const String splashRoute = "/";
  static const String mainRoute = "/mainRoute";
  static const String sneakerDetailsRoute = "/sneaker_details";
  static const String search = "/search";
  static const String notifications = "/notifications";
  static const String login = "/login";
  static const String register = "/register";
  static const String forgetPassword = "/forget_password";
  static const String onboarding = "/onboarding";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteManager.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case RouteManager.mainRoute:
        DependencyInjection.initMain();
        return MaterialPageRoute(builder: (_) => const MainPage());
      case RouteManager.sneakerDetailsRoute:
        final args = settings.arguments as DetailsObject;
        return MaterialPageRoute(
            builder: (_) => SneakerDetailsView(
                  object: args,
                ));
      case RouteManager.search:
        return MaterialPageRoute(builder: (_) => const SearchView());
      case RouteManager.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsView());
      case RouteManager.login:
        DependencyInjection.initLogin();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case RouteManager.register:
        DependencyInjection.initRegister();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case RouteManager.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case RouteManager.onboarding:
        DependencyInjection.initOnboarding();
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      default:
        return _default();
    }
  }

  static Route<dynamic> _default() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(
                  StringManager.noRouteFound,
                ),
              ),
              body: const Center(
                  child: Text(
                StringManager.noRouteFound,
              )),
            ));
  }
}
