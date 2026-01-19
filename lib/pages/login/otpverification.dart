import 'package:donorjunctionhub/pages/login/controller/login_controller.dart';
import 'package:donorjunctionhub/pages/login/widget/login_widget.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/widgets/circle_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

// ignore: must_be_immutable
class OtpVerification extends StatelessWidget {
  OtpVerification({super.key});
  var loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SingleChildScrollView(
            child: Obx(
          () => Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Image.asset(AppImages.otpmobile),
              SizedBox(
                height: 30.h,
              ),
              Pinput(
                autofocus: true,
                onCompleted: (value) {
                  loginController.otpverifi();
                },
                controller: loginController.otpcontroller,
                smsRetriever: loginController.smsRetriever,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                defaultPinTheme: PinTheme(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.lightTextColor),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: loginController.secondsRemaining.value == 0
                      ? GestureDetector(
                          onTap: () => loginController.sendotp(false),
                          child: Text(
                            "Resend",
                            style: NeedFunction.fontstyle(TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 10.sp,
                                color: AppColors.primaryColor)),
                          ),
                        )
                      : Row(
                          children: [
                            Text(
                              "Resend in ",
                              style: NeedFunction.fontstyle(TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10.sp,
                                  color: AppColors.lightTextColor)),
                            ),
                            Text(
                              "${loginController.secondsRemaining.value}",
                              style: NeedFunction.fontstyle(TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10.sp,
                                  color: AppColors.primaryColor)),
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CircleBtn(ontap: loginController.otpverifi),
            ],
          ),
        )),
        bottomNavigationBar: bottomContainer(
            "Please wait...  \nWe will auto-verify the OTP sent to +91${loginController.numbercontroller.text}."),
      ),
    );
  }
}
