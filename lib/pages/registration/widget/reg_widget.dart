import 'package:donorjunctionhub/pages/registration/controller/registration_controller.dart';
import 'package:donorjunctionhub/values/colors.dart';

import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailContainer extends StatelessWidget {
  const DetailContainer(
      {super.key,
      required this.image,
      required this.controller,
      required this.inputType,
      required this.hinttext,
      required this.isdone,
      required this.registrationController});

  final String image;
  final TextEditingController controller;
  final TextInputType inputType;
  final String hinttext;
  final bool isdone;
  final RegistrationController registrationController;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 15.h),
      shadowColor: AppColors.primaryblock,
      child: Container(
        height: 70.h,
        width: Get.width,
        padding: EdgeInsets.all(10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
            ),
            SizedBox(
              width: 150.w,
              child: TextFormField(
                onChanged: (value) {
                  registrationController.validationcheck();
                },
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                controller: controller,
                style: NeedFunction.fontstyle(
                  TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryblock),
                ),
                keyboardType: inputType,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hinttext,
                  hintStyle: NeedFunction.fontstyle(
                    TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightTextColor),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isdone,
              child: Icon(
                Icons.check,
                size: 15.sp,
                color: Colors.green,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DropdownContainer extends StatelessWidget {
  const DropdownContainer(
      {super.key,
      required this.image,
      required this.isdone,
      required this.itemslist,
      required this.registrationController});

  final String image;
  final bool isdone;
  final List<String> itemslist;
  final RegistrationController registrationController;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 15.h),
        shadowColor: AppColors.primaryblock,
        child: Obx(
          () => Container(
            height: 70.h,
            width: Get.width,
            padding: EdgeInsets.all(10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  image,
                ),
                SizedBox(
                    width: 180.w,
                    child: DropdownButtonFormField(
                        initialValue: registrationController.category.value,
                        iconSize: 0,
                        style: NeedFunction.fontstyle(
                          TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryblock),
                        ),
                        focusColor: Colors.transparent,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hoverColor: Colors.transparent,
                            filled: true,
                            fillColor: Colors.transparent),
                        items: itemslist.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: registrationController.category.value ==
                                      "select organization category"
                                  ? NeedFunction.fontstyle(
                                      TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.lightTextColor),
                                    )
                                  : NeedFunction.fontstyle(
                                      TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primaryblock),
                                    ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          registrationController.category.value = value!;
                          registrationController.category.value ==
                                  "select organization category"
                              ? registrationController.cadone(false)
                              : registrationController.cadone(true);
                          registrationController.validationcheck();
                        })),
                Visibility(
                  visible: isdone,
                  child: Icon(
                    Icons.check,
                    size: 15.sp,
                    color: Colors.green,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class FileContainer extends StatelessWidget {
  const FileContainer(
      {super.key,
      required this.image,
      required this.disname,
      required this.isdone,
      required this.ontap,
      required this.filename});

  final String image;
  final String disname;
  final String filename;
  final VoidCallback ontap;
  final bool isdone;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 15.h),
        shadowColor: AppColors.primaryblock,
        child: Container(
          height: 70.h,
          width: Get.width,
          padding: EdgeInsets.all(10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                image,
              ),
              SizedBox(
                  width: 150.w,
                  child: Text(
                    filename,
                    style: NeedFunction.fontstyle(
                      filename == disname
                          ? TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.lightTextColor)
                          : TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryblock),
                    ),
                  )),
              Visibility(
                visible: isdone,
                child: Icon(
                  Icons.check,
                  size: 15.sp,
                  color: Colors.green,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  const AddressCard(
      {super.key,
      required this.address,
      required this.ontap,
      required this.isdone});
  final String address;
  final VoidCallback ontap;
  final bool isdone;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 15.h),
        shadowColor: AppColors.primaryblock,
        child: Container(
          height: 70.h,
          width: Get.width,
          padding: EdgeInsets.all(10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.primaryColor,
                size: 45.sp,
              ),
              SizedBox(
                width: 150.w,
                child: Text(
                  address,
                  style: NeedFunction.fontstyle(
                    address == 'Click here to get your company address.'
                        ? TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightTextColor)
                        : TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryblock),
                  ),
                ),
              ),
              Visibility(
                visible: isdone,
                child: Icon(
                  Icons.check,
                  size: 15.sp,
                  color: Colors.green,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
