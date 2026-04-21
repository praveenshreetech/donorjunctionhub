import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget opetionSetting(VoidCallback ontap, String name) {
  return Container(
    width: Get.width,
    margin: EdgeInsets.symmetric(vertical: 10.h),
    child: GestureDetector(
      onTap: ontap,
      child: Text(
        name,
        style: NeedFunction.fontstyle(TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: AppColors.primaryColor)),
      ),
    ),
  );
}

Widget switchSetting(VoidCallback ontap, String name, RxBool onValue) {
  return Obx(
    () => Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: ontap,
            child: Text(
              name,
              style: NeedFunction.fontstyle(TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: AppColors.primaryColor)),
            ),
          ),
          Switch(
              activeThumbColor: AppColors.primaryColor,
              activeTrackColor: AppColors.primaryColor.withValues(alpha: 0.5),
              inactiveThumbColor: AppColors.primaryblock,
              value: onValue.value,
              onChanged: (value) => ontap())
        ],
      ),
    ),
  );
}
