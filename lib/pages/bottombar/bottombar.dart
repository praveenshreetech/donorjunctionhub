import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:donorjunctionhub/pages/bottombar/controller/bottomcontroller.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BottomBar extends StatelessWidget {
  BottomBar({super.key});
  var bottomcontroller = Get.put(BottomController());

  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      child: Scaffold(
        body: Obx(() => bottomcontroller.page[bottomcontroller.tapindex.value]),
        bottomNavigationBar: Obx(
          () => CurvedNavigationBar(
              index: bottomcontroller.tapindex.value,
              onTap: (value) {
                bottomcontroller.tapindex.value = value;
              },
              color: AppColors.primarywhite,
              animationCurve: Curves.easeInBack,
              backgroundColor: bottomcontroller.tapindex.value == 1
                  ? AppColors.lightTextColor.withValues(alpha: 0.2)
                  : bottomcontroller.tapindex.value == 2
                      ? AppColors.lightTextColor.withValues(alpha: 0.4)
                      : AppColors.primaryGrey.withValues(alpha: 0.2),
              buttonBackgroundColor: AppColors.primaryColor,
              items: [
                ImageIcon(
                  AssetImage(AppImages.addPostA),
                  size: 25.sp,
                  color: bottomcontroller.tapindex.value == 0
                      ? AppColors.primarywhite
                      : AppColors.bgColor,
                ),
                ImageIcon(
                  AssetImage(AppImages.homeA),
                  size: 25.sp,
                  color: bottomcontroller.tapindex.value == 1
                      ? AppColors.primarywhite
                      : AppColors.bgColor,
                ),
                ImageIcon(
                  AssetImage(AppImages.userA),
                  size: 25.sp,
                  color: bottomcontroller.tapindex.value == 2
                      ? AppColors.primarywhite
                      : AppColors.bgColor,
                ),
              ]),
        ),
      ),
    );
  }
}
