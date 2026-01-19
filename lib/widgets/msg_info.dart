import 'dart:io';

import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsgInfo extends StatelessWidget {
  const MsgInfo({super.key, required this.msg});
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250.h,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150.h,
            decoration: BoxDecoration(
              color: AppColors.primarywhite,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  'Your document verification is in progress.',
                  style: NeedFunction.fontstyle(
                    TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 25.h,
                  right: 35.w,
                  child: GestureDetector(
                    onTap: () {
                      if (Platform.isIOS) {
                        exit(0);
                      } else {
                        SystemNavigator.pop();
                      }
                    },
                    child: Text(
                      'OK',
                      style: NeedFunction.fontstyle(
                        TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 50.r,
              backgroundImage: AssetImage(
                AppImages.appLogo2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
