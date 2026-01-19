import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: AppColors.primarywhite,
      child: Image.asset(AppImages.loader),
    );
  }
}
