import 'package:flutter/material.dart';
import 'package:my_profile/constants/app_strings.dart';
import 'package:my_profile/constants/app_theme.dart';
import 'package:my_profile/di/injector.dart';
import 'package:my_profile/router/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.myProfile,
      theme: AppTheme().lightTheme,
      routerConfig: Routes.doRouter,
    );
  }
}
