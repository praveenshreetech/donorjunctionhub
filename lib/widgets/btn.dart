import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BTN extends StatelessWidget {
  const BTN(
      {super.key,
      required this.ontap,
      required this.name,
      required this.bgcolor});
  final VoidCallback ontap;
  final String name;
  final Color bgcolor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 60.w),
        width: Get.width,
        height: 55.h,
        decoration: BoxDecoration(
          color: bgcolor,
          borderRadius: BorderRadius.circular(50.w),
        ),
        child: Center(
          child: Text(
            name,
            style: NeedFunction.fontstyle(TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: AppColors.primarywhite)),
          ),
        ),
      ),
    );
  }
}
