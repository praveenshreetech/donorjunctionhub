import 'package:donorjunctionhub/pages/login/controller/login_controller.dart';
import 'package:donorjunctionhub/routers/routers.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

Widget bottomTC(
  RxBool onvalue,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 30.w),
    height: 50.h,
    child: Obx(
      () => CheckboxListTile(
        activeColor: AppColors.primaryColor,
        title: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
              text:
                  'By continuing, you agree that you have read and accept our ',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 10.sp,
                  color: AppColors.lightTextColor),
              children: [
                TextSpan(
                    text: 'T&Cs ',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.primaryColor,
                    )),
                TextSpan(
                    text: 'and ',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.lightTextColor,
                    )),
                TextSpan(
                    text: 'Privacy Policy.',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10.sp,
                      color: AppColors.primaryColor,
                    )),
              ]),
        ),
        value: onvalue.value,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (bool? value) {
          onvalue.value = value!;
          if (onvalue.value) {
            Get.toNamed(AppRouters.termsandprivacy);
          }
        },
      ),
    ),
  );
}

Widget googlebtn(VoidCallback ontap) {
  return GestureDetector(
    onTap: ontap,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.google,
          width: 50.w,
        ),
        Text(
          " account",
          style: NeedFunction.fontstyle(TextStyle(
              fontWeight: FontWeight.normal,
              color: AppColors.lightTextColor,
              fontSize: 12.sp)),
        )
      ],
    ),
  );
}

Widget mobilenumberfiled(LoginController logincontroller) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30.w),
    child: IntlPhoneField(
      controller: logincontroller.numbercontroller,
      initialCountryCode: "IN",
      disableLengthCheck: false,
      invalidNumberMessage: "mobile number must be 10 digits.",
      disableAutoFillHints: true,
      showDropdownIcon: false,
      dropdownTextStyle: NeedFunction.fontstyle(TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14.sp,
          color: AppColors.lightTextColor)),
      style: NeedFunction.fontstyle(TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14.sp,
          color: AppColors.lightTextColor)),
      cursorColor: AppColors.lightTextColor,
      flagsButtonMargin: EdgeInsets.all(10.w),
      decoration: InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightTextColor),
          borderRadius: BorderRadius.circular(30.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightTextColor),
          borderRadius: BorderRadius.circular(30.w),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightTextColor),
          borderRadius: BorderRadius.circular(30.w),
        ),
      ),
    ),
  );
}

Widget bottomContainer(String msg) {
  return Container(
    height: 60.h,
    padding: EdgeInsets.symmetric(horizontal: 25.w),
    child: Text(
      msg,
      style: NeedFunction.fontstyle(
        TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 10.sp,
            color: AppColors.textColor),
      ),
      textAlign: TextAlign.center,
    ),
  );
}
