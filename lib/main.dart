import 'package:flutter/material.dart';
import 'package:sneakers_shop/app/dependency_injection.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.initApp();
  runApp(const SneakerApp());
}
