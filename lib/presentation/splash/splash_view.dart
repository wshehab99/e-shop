import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sneakers_shop/presentation/resources/asset_manager.dart';
import 'package:sneakers_shop/presentation/resources/route_manger.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  _nextPage() async {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(RouteManager.mainRoute);
    });
  }

  @override
  void initState() {
    _nextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AssetImageManager.splash),
      ),
    );
  }
}
