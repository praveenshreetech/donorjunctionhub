import 'package:donorjunctionhub/pages/logout/logout_controller.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Logout extends StatelessWidget {
  Logout({super.key});

  var logoutcontroller = Get.put(LogoutController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primarywhite,
      width: Get.width,
      height: Get.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.logOut),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0.w),
            child: Text(
              "Are you sure you want to log out of your account? ",
              style: NeedFunction.fontstyle(
                TextStyle(
                  decoration: TextDecoration.none,
                  color: AppColors.primaryblock,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0.w),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: NeedFunction.fontstyle(TextStyle(
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: AppColors.primarywhite)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => logoutcontroller.logoutUser(),
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Center(
                        child: Text(
                          "Logout",
                          style: NeedFunction.fontstyle(TextStyle(
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none,
                              fontSize: 14.sp,
                              color: AppColors.primaryColor)),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
