import 'package:donorjunctionhub/pages/splash/controller/splash_controller.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Splash extends StatelessWidget {
  Splash({super.key});
  var splashcontroller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.splashBg),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high),
      ),
      child: Center(
        child: Image.asset(AppImages.appLogo),
      ),
    );
  }
}
