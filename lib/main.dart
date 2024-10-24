import 'package:assignment/presentation/screen/splash/splash_screen.dart';
import 'package:assignment/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'data/sources/remote/api_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAndRun();
  runApp(const MovieApp());
}

Future<void> initAndRun() async {
  ApiClient.client.init();
  GetStorage.init('movies');
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      themeMode: ThemeMode.light,
      theme: AppTheme.dark(),
      home: const SplashScreen(),
    );
  }
}
