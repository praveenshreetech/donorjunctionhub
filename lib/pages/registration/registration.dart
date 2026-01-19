import 'package:donorjunctionhub/pages/registration/controller/registration_controller.dart';
import 'package:donorjunctionhub/pages/registration/widget/reg_widget.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';

import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:donorjunctionhub/widgets/btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Registration extends StatelessWidget {
  Registration({super.key});
  var registrationcontroller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Obx(
              () => SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    Text(
                      "Organization Details",
                      style: NeedFunction.fontstyle(
                        TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                            color: AppColors.primaryblock),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    DetailContainer(
                        registrationController: registrationcontroller,
                        image: AppImages.hospital,
                        controller: registrationcontroller.namecontroller,
                        inputType: TextInputType.name,
                        hinttext: 'Organization Name',
                        isdone: registrationcontroller.namedone.value),
                    FileContainer(
                      disname: 'Organization Image',
                      image: AppImages.hospital,
                      ontap: registrationcontroller.pickOrgImage,
                      isdone: registrationcontroller.orgImagedone.value,
                      filename: registrationcontroller.orgImage.value,
                    ),
                    DetailContainer(
                        registrationController: registrationcontroller,
                        image: AppImages.mail,
                        controller: registrationcontroller.mailcontroller,
                        inputType: TextInputType.emailAddress,
                        hinttext: 'Email Address',
                        isdone: registrationcontroller.maildone.value),
                    DropdownContainer(
                        registrationController: registrationcontroller,
                        image: AppImages.categories,
                        isdone: registrationcontroller.cadone.value,
                        itemslist: AppString.organizationcategory),
                    AddressCard(
                      ontap: registrationcontroller.getaddress,
                      isdone: registrationcontroller.addressDone.value,
                      address: registrationcontroller.orgAddress.value,
                    ),
                    DetailContainer(
                        registrationController: registrationcontroller,
                        image: AppImages.licensNumber,
                        controller:
                            registrationcontroller.licensenumbercontroller,
                        inputType: TextInputType.multiline,
                        hinttext: 'License Number',
                        isdone: registrationcontroller.licdone.value),
                    FileContainer(
                      disname: 'License Document',
                      image: AppImages.licenseDoc,
                      ontap: registrationcontroller.pickdocument,
                      isdone: registrationcontroller.docdone.value,
                      filename: registrationcontroller.documentname.value,
                    ),
                  ],
                ),
              ),
            )),
        bottomNavigationBar: Container(
            height: 100.h,
            color: Colors.transparent,
            child: Obx(
              () => Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  BTN(
                    ontap: registrationcontroller.orgRegistration,
                    name: "Done",
                    bgcolor: registrationcontroller.btnEnble.value
                        ? AppColors.primaryColor
                        : AppColors.textColor,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
