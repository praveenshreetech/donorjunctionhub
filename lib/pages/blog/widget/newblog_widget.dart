import 'dart:io';
import 'package:donorjunctionhub/pages/userblog/controller/new_blog_conroller.dart';

import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget imagepickerview(NewBlogConroller blogcontroller) {
  return Container(
    height: Get.width / 1.8,
    width: Get.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: Obx(
      () => Stack(
        children: [
          blogcontroller.uploadimges.value == ''
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.grey.withValues(alpha: 0.2)),
                  ),
                )
              : Container(
                  width: Get.width,
                  height: 250.h,
                  margin: EdgeInsets.symmetric(horizontal: 20.0.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.grey.withValues(alpha: 0.2),
                    image: DecorationImage(
                      image: FileImage(
                        File(blogcontroller.uploadimges.value),
                      ),
                    ),
                  ),
                ),
          // Swiper(
          //     itemCount: blogcontroller.blogimages.length,
          //     layout: SwiperLayout.TINDER,
          //     itemWidth: Get.width,
          //     itemHeight: 225.h,
          //     onIndexChanged: (value) {
          //       blogcontroller.picterindex.value = value;
          //     },
          //     itemBuilder: (context, index) {
          //       return Container(
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10.r),
          //           image: DecorationImage(
          //               image: FileImage(
          //                 File(blogcontroller.blogimages[index].path),
          //               ),
          //               fit: BoxFit.fill),
          //         ),
          //       );
          //     },
          //   ),
          Positioned(
              top: 15.h,
              left: 25.w,
              child: circleBtn(
                  () => blogcontroller.pickImages(), AppImages.addimage)),
          // Positioned(
          //     top: 55.h,
          //     left: 25.w,
          //     child: circleBtn(() {}, AppImages.editimage)),
          // Positioned(
          //   top: 20.h,
          //   right: 30.w,
          //   child: blogcontroller.blogimages.isEmpty
          //       ? Container()
          //       : Container(
          //           width: 30.w,
          //           height: 20.h,
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(10.r),
          //               color: AppColors.primaryblock.withOpacity(0.7)),
          //           child: Center(
          //             child: Text(
          //               "${blogcontroller.picterindex.value + 1} / ${blogcontroller.blogimages.length}",
          //               style: NeedFunction.fontstyle(TextStyle(
          //                   fontWeight: FontWeight.w400,
          //                   fontSize: 8.sp,
          //                   color: AppColors.primarywhite)),
          //             ),
          //           ),
          //         ),
          // ),
        ],
      ),
    ),
  );
}

Widget circleBtn(VoidCallback ontap, String image) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 5.r,
        )
      ], shape: BoxShape.circle, color: AppColors.primarywhite),
      child: Center(
        child: Image.asset(
          image,
          width: 25.w,
          height: 25.h,
        ),
      ),
    ),
  );
}

Widget dropdown(NewBlogConroller blogcontroller) {
  return Card(
    child: Container(
      padding: EdgeInsets.only(left: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.containerColor.withValues(alpha: 0.2),
      ),
      height: 45.h,
      width: Get.width / 2,
      alignment: AlignmentDirectional.center,
      child: Obx(
        () => DropdownButtonFormField(
            alignment: AlignmentDirectional.center,
            icon: Visibility(visible: false, child: Icon(Icons.arrow_downward)),
            style: NeedFunction.fontstyle(
              TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: AppColors.primaryblock),
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            initialValue: blogcontroller.postType.value,
            items: AppString.postTypeList
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        textAlign: TextAlign.center,
                        item.toString(),
                        style: NeedFunction.fontstyle(
                          TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: AppColors.primaryblock),
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (type) {
              blogcontroller.postType.value = type.toString();
            }),
      ),
    ),
  );
}

Widget postdatepick(BuildContext context, TextEditingController controller) {
  return Card(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.containerColor.withValues(alpha: 0.2),
      ),
      height: 45.h,
      child: TextFormField(
        textAlign: TextAlign.center,
        readOnly: true,
        style: NeedFunction.fontstyle(
          TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.primaryblock,
              fontSize: 14.sp),
        ),
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Date',
            hintStyle: NeedFunction.fontstyle(
              TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryblock,
                  fontSize: 14.sp),
            )),
        onTap: () async {
          DateTime? datepick = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(2050),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: AppColors.primaryColor,
                    onPrimary: AppColors.primarywhite,
                    onSurface: AppColors.textColor,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );
          if (datepick != null) {
            controller.text = DateFormat('dd-MM-yyyy').format(datepick);
          }
        },
      ),
    ),
  );
}

Widget blogTextfield(String hit, TextEditingController controller,
    TextInputType inputtype, int lent) {
  return Container(
    width: Get.width,
    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    padding: EdgeInsets.all(10.r),
    height: 60.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(color: AppColors.lightTextColor, width: 0.5),
    ),
    child: TextFormField(
      maxLength: lent,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: controller,
      keyboardType: inputtype,
      style: NeedFunction.fontstyle(
        TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
        ),
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hit,
        hintStyle: NeedFunction.fontstyle(
          TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: AppColors.lightTextColor),
        ),
      ),
    ),
  );
}

Widget descriptionWidget(
  String hit,
  TextEditingController controller,
) {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(color: AppColors.lightTextColor, width: 0.5),
    ),
    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
    padding: EdgeInsets.all(10.r),
    child: TextFormField(
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: controller,
      keyboardType: TextInputType.multiline,
      style: NeedFunction.fontstyle(
        TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
        ),
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hit,
        hintStyle: NeedFunction.fontstyle(
          TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: AppColors.lightTextColor),
        ),
      ),
    ),
  );
}
