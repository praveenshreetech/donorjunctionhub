import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget countCard(String image, String count, String title) {
  return Container(
    width: 150.w,
    height: 110.h,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          count,
          style: NeedFunction.fontstyle(
            TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.sp,
                color: AppColors.primaryColor),
          ),
        ),
        Text(
          title,
          style: NeedFunction.fontstyle(
            TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: AppColors.textColor),
          ),
        ),
      ],
    ),
  );
}

Widget btnInfo(String image, String title, VoidCallback ontap) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      width: Get.width,
      height: 70.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.primarywhite),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 40.w,
            height: 40.h,
          ),
          SizedBox(
            width: 30.w,
          ),
          Text(
            title,
            style: NeedFunction.fontstyle(TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 14.sp,
                color: AppColors.primaryblock)),
          )
        ],
      ),
    ),
  );
}

Widget btnInfoIcon(IconData image, String title, VoidCallback ontap) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      width: Get.width,
      height: 70.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.primarywhite),
      child: Row(
        children: [
          Icon(
            image,
            size: 35.sp,
            color: AppColors.primaryColor,
          ),
          SizedBox(
            width: 30.w,
          ),
          Text(
            title,
            style: NeedFunction.fontstyle(TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 14.sp,
                color: AppColors.primaryblock)),
          )
        ],
      ),
    ),
  );
}
