import 'package:donorjunctionhub/model/alldonorsmodel.dart';
import 'package:donorjunctionhub/model/hospital_model.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

AppBar chatListAppBar() {
  return AppBar(
    title: Text(
      'Chat',
      style: NeedFunction.fontstyle(
          TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp)),
    ),
  );
}

Widget chatListContainer(DonorData data) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: data.image == ''
                    ? AssetImage(AppImages.userimage)
                    : NetworkImage(NetworkHandler.buildImageUrl(
                        "donors/${data.id}/${data.image}")),
                fit: BoxFit.cover),
          ),
        ),
        SizedBox(
          width: 15.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Text(
              data.name ?? "",
              style: NeedFunction.fontstyle(
                  TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              data.city ?? "",
              style: NeedFunction.fontstyle(
                TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10.sp,
                    color: AppColors.lightTextColor),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

AppBar chatAppBar(DonorData donor, HospitalDetails hdata) {
  return AppBar(
    backgroundColor: AppColors.primarywhite,
    title: Row(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: donor.image == ''
                    ? AssetImage(AppImages.userimage)
                    : NetworkImage(NetworkHandler.buildImageUrl(
                        "donors/${donor.id}/${donor.image}")),
                fit: BoxFit.cover),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              donor.name ?? "",
              style: NeedFunction.fontstyle(
                  TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp)),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              donor.city ?? " ",
              style: NeedFunction.fontstyle(
                TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10.sp,
                    color: AppColors.lightTextColor),
              ),
            ),
          ],
        )
      ],
    ),
    actions: [
      GestureDetector(
        onTap: () async {
          await NeedFunction()
              .makeCall(hdata.mobileNo ?? "", donor.mobileNumber ?? "");
        },
        child: Icon(
          Icons.call_outlined,
          color: AppColors.primaryblock,
        ),
      ),
      SizedBox(
        width: 20.w,
      )
    ],
  );
}

Widget messageWidget(bool ishospital, String message) {
  return ishospital
      ? Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            width: Get.width / 2.2,
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r),
              ),
            ),
            child: Center(
              child: Text(
                message,
                style: NeedFunction.fontstyle(
                  TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: AppColors.primarywhite),
                ),
              ),
            ),
          ),
        )
      : Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            width: Get.width / 2.2,
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColors.primarywhite,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r),
              ),
            ),
            child: Center(
              child: Text(
                message,
                style: NeedFunction.fontstyle(
                  TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: AppColors.primaryblock),
                ),
              ),
            ),
          ),
        );
}

Widget chatBox(TextEditingController textcontroller, VoidCallback ontap) {
  return Container(
    height: 60.h,
    width: Get.width,
    padding: EdgeInsets.all(10.r),
    decoration: const BoxDecoration(color: Colors.transparent),
    child: Row(
      children: [
        Expanded(
          child: Container(
            height: 50.h,
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                color: AppColors.primarywhite),
            child: TextFormField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: textcontroller,
              keyboardType: TextInputType.text,
              style: NeedFunction.fontstyle(
                TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12.sp,
                    color: AppColors.primaryblock),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Message ',
                hintStyle: NeedFunction.fontstyle(
                  TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12.sp,
                      color: AppColors.lightTextColor),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
        GestureDetector(
          onTap: ontap,
          child: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: AppColors.primaryColor),
            child: Center(
              child: Image.asset(
                AppImages.send,
                width: 25.w,
                height: 25.h,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
