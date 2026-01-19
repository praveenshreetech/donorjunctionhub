import 'package:donorjunctionhub/pages/settings/controller/settings_controller.dart';
import 'package:donorjunctionhub/pages/settings/widget/setting_widget.dart';
import 'package:donorjunctionhub/routers/routers.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Settings extends StatelessWidget {
  Settings({super.key});
  var settingcontroller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: NeedFunction.fontstyle(
              TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              opetionSetting(() {
                Get.toNamed(AppRouters.termsandprivacy);
              }, "Terms And Conditions"),
              switchSetting(() {
                settingcontroller.getAvailableBiometrics();
              }, "Fingerprint ", settingcontroller.fingerprintlock),
              switchSetting(() {
                settingcontroller.stopNotification();
              }, "Notification", settingcontroller.notificationON),
              switchSetting(() {
                settingcontroller.stopLocation();
              }, "Location", settingcontroller.onLocation),
              opetionSetting(() {
                Get.toNamed(AppRouters.logout);
              }, "Logout"),
            ],
          ),
        ),
      ),
    );
  }
}
