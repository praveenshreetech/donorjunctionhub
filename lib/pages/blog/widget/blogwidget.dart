import 'package:donorjunctionhub/model/hospital_model.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/pages/blog/model/all_blog_model.dart';
import 'package:donorjunctionhub/routers/routers.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

Widget topbar() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Blog",
          style: NeedFunction.fontstyle(
            TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryblock,
                fontSize: 20.sp),
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                bool isuser = await NeedFunction().gusetcheck();
                if (isuser) {
                  NeedFunction.toastmsg(
                      "You are in a guest account. Please log in. ");
                } else {
                  Get.toNamed(AppRouters.addblog);
                }
              },
              child: Image.asset(
                AppImages.addBlog,
                width: 25.w,
              ),
            ),
            SizedBox(
              width: 18.w,
            ),
          ],
        )
      ],
    ),
  );
}

Widget blogContainer(BlogData data, HospitalDetails hosdata) {
  return Container(
    height: 400.h,
    width: Get.width,
    margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
    child: Stack(
      children: [
        Container(
          height: 355.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10.h,
                child: Container(
                  width: 300.w,
                  height: 340.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                        image: NetworkImage(
                          NetworkHandler.buildImageUrl(
                              "${data.hospitalId}/${data.image}"),
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                top: 20.h,
                left: 20.w,
                right: 20.w,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15.r,
                      backgroundImage: NetworkImage(
                          NetworkHandler.buildImageUrl(
                              '${hosdata.id}/${hosdata.hospitalImages}')),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    SizedBox(
                      width: 100.w,
                      child: Text(
                        "${hosdata.hospitalName ?? ""} ${hosdata.category ?? ""}",
                        style: NeedFunction.fontstyle(
                          TextStyle(
                              shadows: [Shadow(blurRadius: 5.r)],
                              fontWeight: FontWeight.bold,
                              fontSize: 10.sp,
                              color: AppColors.primarywhite),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    // Text(
                    //   "1 Min ago",
                    //   style: NeedFunction.fontstyle(
                    //     TextStyle(
                    //         shadows: [Shadow(blurRadius: 5.r)],
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 8.sp,
                    //         color: AppColors.primarywhite),
                    //   ),
                    // ),
                    SizedBox(
                      width: 15.w,
                    ),
                    // Container(
                    //   height: 20.h,
                    //   width: 30.w,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10.r),
                    //     color: AppColors.primaryGrey.withOpacity(0.58),
                    //   ),
                    //   child: Center(
                    //     child: Text(
                    //       "2/3",
                    //       style: NeedFunction.fontstyle(
                    //         TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 8.sp,
                    //             color: AppColors.primarywhite),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      width: 10.w,
                    ),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Icon(
                    //     Icons.more_vert,
                    //     size: 15.sp,
                    //     color: AppColors.primarywhite,
                    //     shadows: [Shadow(blurRadius: 5.r)],
                    //   ),
                    // )
                  ],
                ),
              ),
              Positioned(
                bottom: 6,
                child: Container(
                  height: 129.h,
                  width: 300.w,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.primaryColor.withValues(alpha: 0.63),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${hosdata.hospitalName} ${hosdata.category}",
                        style: NeedFunction.fontstyle(
                          TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: AppColors.primarywhite),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        "${data.category}   ${data.campDate}",
                        style: NeedFunction.fontstyle(
                          TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: AppColors.primarywhite),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        "${data.title} ${data.description}",
                        style: NeedFunction.fontstyle(
                          TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 8.sp,
                              color: AppColors.primarywhite),
                        ),
                        textAlign: TextAlign.justify,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 20.h,
          right: 20.w,
          child: GestureDetector(
            onTap: () {
              String mapurl =
                  'https://www.google.com/maps/search/?api=1&query=${hosdata.latitude},${hosdata.longitude}';
              Share.share(
                'Hi Your nearby location, ${hosdata.hospitalName}${hosdata.category}, arranged for a blood camp. \nContact person number: ${data.contactNo} \nLocation: $mapurl\nIf you are a new user, download the app: https://play.google.com/store/apps/details?id=com.userjunction',
              );
            },
            child: Container(
              width: 30.w,
              height: 30.h,
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primarywhite),
              child: Image.asset(
                AppImages.share,
                color: AppColors.primaryblock,
                width: 30.w,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
