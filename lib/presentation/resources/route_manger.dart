import 'package:flutter/material.dart';
import 'package:sneakers_shop/app/dependency_injection.dart';
import 'package:sneakers_shop/presentation/forget_password/forget_password.dart';
import 'package:sneakers_shop/presentation/login/view/login_view.dart';
import 'package:sneakers_shop/presentation/onboarding/view/onboarding_view.dart';
import 'package:sneakers_shop/presentation/register/register_view.dart';
import 'package:sneakers_shop/presentation/search/search_view.dart';
import 'package:sneakers_shop/presentation/sneaker_details/view/sneaker_details_view.dart';
import 'package:sneakers_shop/presentation/splash/splash_view.dart';

import '../main/view/main_page.dart';
import '../notifications/notifications.dart';
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
        return MaterialPageRoute(builder: (_) => SplashView());
      case RouteManager.mainRoute:
        return MaterialPageRoute(builder: (_) => MainPage());
      case RouteManager.sneakerDetailsRoute:
        return MaterialPageRoute(builder: (_) => SneakerDetailsView());
      case RouteManager.search:
        return MaterialPageRoute(builder: (_) => SearchView());
      case RouteManager.notifications:
        return MaterialPageRoute(builder: (_) => NotificationsView());
      case RouteManager.login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RouteManager.register:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case RouteManager.forgetPassword:
        return MaterialPageRoute(builder: (_) => ForgetPasswordView());
      case RouteManager.onboarding:
        DependencyInjection.initOnboarding();
        return MaterialPageRoute(builder: (_) => OnboardingView());
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
