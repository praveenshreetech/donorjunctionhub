import 'package:donorjunctionhub/pages/notification/model/notification_model.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget notificationCondainer(NotificationList notification) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
    child: Row(
      children: [
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: AppColors.primaryColor),
          child: Center(
            child: Image.asset(
              AppImages.notification,
              width: 30.w,
              height: 30.h,
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: Text(
            notification.content ?? "",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: NeedFunction.fontstyle(TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: notification.status == '0'
                    ? AppColors.primaryblock
                    : AppColors.lightTextColor)),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              NeedFunction().blogDate(notification.createdAt.toString()),
              style: NeedFunction.fontstyle(TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10.sp,
                  color: AppColors.lightTextColor)),
            ),
          ],
        )
      ],
    ),
  );
}
