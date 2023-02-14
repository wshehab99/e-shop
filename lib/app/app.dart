import 'package:flutter/material.dart';

import '../presentation/resources/route_manger.dart';
import '../presentation/resources/theme_manager.dart';

class SneakerApp extends StatelessWidget {
  const SneakerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sneaker Shop',
      theme: ThemeManager.appTheme,
      initialRoute: RouteManager.splashRoute,
      onGenerateRoute: RouteGenerator.getRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
