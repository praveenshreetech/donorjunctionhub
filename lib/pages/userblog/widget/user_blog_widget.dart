import 'package:donorjunctionhub/routers/routers.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

AppBar userBlogTopBar() {
  return AppBar(
    backgroundColor: AppColors.primarywhite,
    elevation: 10,
    centerTitle: true,
    title: Text(
      "Blog",
      style: NeedFunction.fontstyle(
        TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryblock,
            fontSize: 20.sp),
      ),
    ),
    actions: [
      GestureDetector(
        onTap: () {
          Get.toNamed(AppRouters.addblog);
        },
        child: Image.asset(
          AppImages.addBlog,
          width: 25.w,
        ),
      ),
      SizedBox(
        width: 20.w,
      )
    ],
  );
}
