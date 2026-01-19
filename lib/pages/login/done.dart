import 'package:donorjunctionhub/routers/routers.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Done extends StatelessWidget {
  const Done({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 50.h,
            ),
            Text(
              "Welcome",
              style: GoogleFonts.justMeAgainDownHere(
                  fontWeight: FontWeight.normal,
                  fontSize: 50.sp,
                  color: AppColors.primaryblock),
            ),
            Text(
              "To start press below",
              style: NeedFunction.fontstyle(TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: AppColors.textColor)),
            ),
            Image.asset(AppImages.appLogo2),
            SizedBox(
              height: 30.h,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRouters.bottombar);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Card(
                  child: Container(
                    height: 71.h,
                    width: Get.width,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                      color: AppColors.primarywhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Let’s Go",
                          style: NeedFunction.fontstyle(TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: AppColors.primaryblock)),
                        ),
                        Container(
                          width: 40.w,
                          height: 54.h,
                          decoration: BoxDecoration(
                              color: AppColors.primaryblock,
                              borderRadius: BorderRadius.circular(5.w)),
                          child: Icon(
                            Icons.arrow_forward,
                            color: AppColors.primarywhite,
                            size: 30.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
