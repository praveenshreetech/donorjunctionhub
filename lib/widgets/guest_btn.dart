import 'package:donorjunctionhub/routers/routers.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuestBTN extends StatelessWidget {
  const GuestBTN({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("id", "1");
        Get.toNamed(AppRouters.bottombar);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 60.w),
        width: Get.width,
        height: 55.h,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(50.w),
        ),
        child: Center(
          child: Text(
            "Guest",
            style: NeedFunction.fontstyle(TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: AppColors.primaryColor)),
          ),
        ),
      ),
    );
  }
}
