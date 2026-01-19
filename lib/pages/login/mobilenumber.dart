import 'package:donorjunctionhub/pages/login/controller/login_controller.dart';
import 'package:donorjunctionhub/pages/login/widget/login_widget.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/widgets/circle_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MobileNumber extends StatelessWidget {
  MobileNumber({super.key});
  var logincontroller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Image.asset(AppImages.mobile),
            SizedBox(
              height: 30.h,
            ),
            mobilenumberfiled(logincontroller),
            SizedBox(
              height: 30.h,
            ),
            CircleBtn(ontap: () => logincontroller.sendotp(true)),
          ],
        ),
      ),
      bottomNavigationBar: bottomContainer(
          "This number will be used for blood donation-related communication. You will receive an SMS with a code for verification."),
    );
  }
}
