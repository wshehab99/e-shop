import 'package:flutter/material.dart';
import 'package:sneakers_shop/app/dependency_injection.dart';
import 'package:sneakers_shop/presentation/resources/them_manager/view_model/theme_view_model.dart';

import '../presentation/resources/route_manger.dart';
import '../presentation/resources/them_manager/theme_manager.dart';

class SneakerApp extends StatefulWidget {
  const SneakerApp({super.key});

  @override
  State<SneakerApp> createState() => _SneakerAppState();
}

class _SneakerAppState extends State<SneakerApp> {
  final ThemeMangerViewModel _themeMangerViewModel =
      DependencyInjection.instance<ThemeMangerViewModel>();
  @override
  void initState() {
    super.initState();
    _themeMangerViewModel.init();
  }

  @override
  void dispose() {
    _themeMangerViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _themeMangerViewModel.isDarkOutput,
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Sneaker Shop',
            theme: snapshot.data ?? false
                ? ThemeManager.darkTheme
                : ThemeManager.appTheme,
            themeMode:
                snapshot.data ?? false ? ThemeMode.dark : ThemeMode.light,
            initialRoute: RouteManager.splashRoute,
            onGenerateRoute: RouteGenerator.getRoute,
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
