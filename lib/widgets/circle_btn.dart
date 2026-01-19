import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleBtn extends StatelessWidget {
  const CircleBtn({super.key, required this.ontap});
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 60.w,
        height: 60.h,
        padding: EdgeInsets.only(left: 5.w),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: AppColors.primaryColor),
        child: Center(
          child: Image.asset(
            AppImages.arrowforward,
            width: 15.w,
          ),
        ),
      ),
    );
  }
}
