import 'package:donorjunctionhub/model/alldonorsmodel.dart';
import 'package:donorjunctionhub/model/hospital_model.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/pages/map_view/map_controller.dart';
import 'package:donorjunctionhub/routers/routers.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget userBottomBar(DonorData donor, HospitalDetails hdata) {
  return SizedBox(
    height: 200.h,
    width: Get.width,
    child: Stack(
      children: [
        Positioned(
          bottom: 0,
          child: Container(
            height: 180.h,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.primarywhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 130.w,
                  height: 130.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                    ),
                    image: DecorationImage(
                        image: donor.image == ""
                            ? AssetImage(AppImages.userimage)
                            : NetworkImage(
                                NetworkHandler.buildImageUrl(
                                    "donors/${donor.id}/${donor.image}"),
                              ),
                        fit: BoxFit.cover),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      donor.name ?? " ",
                      style: NeedFunction.fontstyle(
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp),
                      ),
                    ),
                    Text(
                      "${donor.city},${donor.country!.split(' ').last.toString()}",
                      style: NeedFunction.fontstyle(
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 13.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 50.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: 50.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor),
                      child: Center(
                        child: Text(
                          donor.bloodGroup ?? "",
                          style: NeedFunction.fontstyle(TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: AppColors.primarywhite)),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 10.h,
          left: 45.w,
          right: 45.w,
          child: Container(
            width: 200.w,
            height: 50.h,
            decoration: BoxDecoration(color: AppColors.primaryColor),
          ),
        ),
        Positioned(
            left: 30.w,
            top: 0.h,
            child: donorCRLBTN(AppColors.primaryColor, AppImages.call, () {
              NeedFunction()
                  .makeCall(hdata.mobileNo ?? "", donor.mobileNumber ?? "");
            })),
        Positioned(
            right: 30.w,
            top: 0.h,
            child: donorCRLBTN(AppColors.primaryblock, AppImages.msg, () {
              Get.toNamed(AppRouters.chatpage, arguments: {'donor': donor});
            })),
      ],
    ),
  );
}

Widget donorCRLBTN(Color bgcolor, String imgage, VoidCallback ontap) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      width: 70.w,
      height: 70.h,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primarywhite, width: 7.w),
          shape: BoxShape.circle,
          color: bgcolor),
      child: Center(
        child: Image.asset(
          imgage,
          width: 40.w,
          height: 40.h,
        ),
      ),
    ),
  );
}

Widget placelist(List list, MapController controller) {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(color: AppColors.primarywhite),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        list.length,
        (index) {
          return ListTile(
            onTap: () {
              controller.placeController.text = list[index]['description'];
              controller.scarchAdreess(list[index]['description']);
              controller.placelist.clear();
            },
            title: Text(
              list[index]['description'],
              style: NeedFunction.fontstyle(
                TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
            ),
          );
        },
      ),
    ),
  );
}
