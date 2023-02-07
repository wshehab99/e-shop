import 'package:flutter/material.dart';
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
