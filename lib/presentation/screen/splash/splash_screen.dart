import 'package:assignment/presentation/binding/main_binding.dart';
import 'package:assignment/presentation/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () => Get.offAll(const MainScreen(), binding: MainBinding()));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        children: [Center(
         child: Image.asset('assets/images/cinema.png',height: 100,)
        )],
      ),
    );
  }
}
