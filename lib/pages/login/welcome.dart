import 'package:donorjunctionhub/pages/login/controller/login_controller.dart';
import 'package:donorjunctionhub/pages/login/widget/login_widget.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/widgets/btn.dart';
import 'package:donorjunctionhub/widgets/guest_btn.dart';
import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Welcome extends StatelessWidget {
  Welcome({super.key});
  var logincontroller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Container(
                width: Get.width,
                height: 386,
                decoration: BoxDecoration(
                  color: AppColors.lightTextColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.w),
                    bottomRight: Radius.circular(50.w),
                  ),
                ),
                child: Image.asset(AppImages.bloodheand),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "BLOOD DONATION IS A",
                style: NeedFunction.fontstyle(
                  TextStyle(
                      fontWeight: FontWeight.normal,
                      color: AppColors.lightTextColor,
                      fontSize: 10.sp),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "GREAT ACT OF KINDNESS",
                style: NeedFunction.fontstyle(
                  TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textColor,
                      fontSize: 14.sp),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              BTN(
                ontap: logincontroller.mobilenumberpage,
                name: "Phone number",
                bgcolor: AppColors.primaryColor,
              ),
              SizedBox(
                height: 20.h,
              ),
              const GuestBTN(),
            ],
          ),
        ),
        bottomNavigationBar: bottomTC(logincontroller.tc),
      ),
    );
  }
}
