import 'package:donorjunctionhub/model/alldonorsmodel.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/pages/donorslist/controller/dlist_controller.dart';
import 'package:donorjunctionhub/routers/routers.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

AppBar bar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Text(
      'Donors',
      style: NeedFunction.fontstyle(
        TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: AppColors.primaryblock),
      ),
    ),
  );
}

Widget infoBtn(VoidCallback ontap, String text) {
  return GestureDetector(
    onTap: ontap,
    child: Text(
      text,
      style: NeedFunction.fontstyle(TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 12.sp,
          color: AppColors.primaryblock)),
    ),
  );
}

Widget bottomfitter(DlistController controller) {
  return Card(
    elevation: 4,
    shadowColor: Colors.black12,
    child: SizedBox(
      height: 100.h,
      child: Column(
        children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(
                () => Row(
                  children: List.generate(AppString.bloodGroup.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        controller.bloodShow.value =
                            AppString.bloodGroup[index];
                        if (controller.bloodShow.value == 'All') {
                          controller.getAlldonor();
                        } else {
                          controller.flitterblood();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.bloodShow.value ==
                                    AppString.bloodGroup[index]
                                ? AppColors.primaryColor
                                : AppColors.primarywhite),
                        child: Center(
                          child: Text(
                            AppString.bloodGroup[index],
                            style: NeedFunction.fontstyle(
                              TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15.sp,
                                  color: controller.bloodShow.value ==
                                          AppString.bloodGroup[index]
                                      ? AppColors.primarywhite
                                      : AppColors.primaryblock),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              )),
          SizedBox(
            height: 5.h,
          ),
          Container(
            width: Get.width,
            height: 1.h,
            decoration: BoxDecoration(color: AppColors.lightTextColor),
          ),
          Expanded(
              child: Row(
            children: [
              SizedBox(
                width: 10.w,
              ),
              // GestureDetector(
              //   onTap: () {},
              //   child: Icon(
              //     Icons.search,
              //     size: 30.sp,
              //     color: AppColors.primaryblock,
              //   ),
              // ),
              Expanded(
                child: Center(
                  child: Text(
                    '${controller.donorslist.length} Donors',
                    style: NeedFunction.fontstyle(
                      TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.sp,
                          color: AppColors.primaryblock),
                    ),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    ),
  );
}

// ignore: must_be_immutable
class DonorContainer extends StatelessWidget {
  DonorContainer(
      {super.key, required this.donordata, required this.controller});
  final DonorData donordata;
  final DlistController controller;

  RxBool showinfo = false.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
        child: Card(
          elevation: 4,
          shadowColor: Colors.black12,
          child: Obx(
            () => Container(
                width: Get.width,
                height: showinfo.value ? 145.h : 90.h,
                decoration: BoxDecoration(
                  color: AppColors.primarywhite,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (donordata.lastDonate == null) {
                          return;
                        }
                        if (NeedFunction()
                                .bloodreadyStr(donordata.lastDonate ?? "") ==
                            'Ready') {
                          showinfo.value = !showinfo.value;
                        }
                      },
                      child: Container(
                        width: Get.width,
                        height: 90.h,
                        decoration: BoxDecoration(
                          color: AppColors.primarywhite,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 5.0,
                              offset: Offset(0.0, 5),
                            ),
                            BoxShadow(
                              color: Colors.transparent,
                              offset: Offset(-5, 0),
                            ),
                            BoxShadow(
                              color: Colors.transparent,
                              offset: Offset(5, 0),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            CircleAvatar(
                              radius: 25.r,
                              foregroundColor: Colors.transparent,
                              foregroundImage: NetworkImage(
                                NetworkHandler.buildImageUrl(
                                    "donors/${donordata.id ?? ""}/${donordata.image ?? ""}"),
                              ),
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.asset(
                                  AppImages.userimage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            SizedBox(
                              width: 120.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 3.0.w),
                                    child: Text(
                                      donordata.name ?? "",
                                      style: NeedFunction.fontstyle(TextStyle(
                                          color: AppColors.primaryblock,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 10.sp)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  SizedBox(
                                    width: 120.w,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          AppImages.location,
                                          width: 15.w,
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        SizedBox(
                                          width: 100.w,
                                          child: Text(
                                            "${donordata.city},${donordata.country!.split(' ').last.toString()}",
                                            maxLines: 1,
                                            style: NeedFunction.fontstyle(
                                              TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: AppColors.primaryblock,
                                                  fontSize: 8.sp),
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Expanded(
                              child: Container(
                                height: 90.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.w),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          donordata.lastDonate == null
                                              ? AppImages.notready
                                              : NeedFunction().bloodreadyImg(
                                                  donordata.lastDonate ?? "")),
                                      fit: BoxFit.cover),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      left: 0,
                                      child: Container(
                                        width: 50.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primaryColor),
                                        child: Center(
                                          child: Text(
                                            donordata.bloodGroup ?? "",
                                            style: NeedFunction.fontstyle(
                                              TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 15.sp,
                                                  color:
                                                      AppColors.primarywhite),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 5,
                                      child: RotatedBox(
                                        quarterTurns: 1,
                                        child: Text(
                                          donordata.lastDonate == null
                                              ? "Not Ready"
                                              : NeedFunction().bloodreadyStr(
                                                  donordata.lastDonate ?? ""),
                                          style: NeedFunction.fontstyle(
                                            TextStyle(
                                                fontWeight: FontWeight.w900,
                                                letterSpacing: 3,
                                                fontSize: 13.sp,
                                                color: AppColors.primarywhite),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: donordata.lastDonate == null
                          ? false
                          : NeedFunction().bloodreadyStr(
                                      donordata.lastDonate ?? "") ==
                                  'Ready'
                              ? showinfo.value
                              : false,
                      child: Positioned(
                        bottom: 5,
                        left: 25.w,
                        right: 25.w,
                        child: SizedBox(
                          height: 30.h,
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              infoBtn(() {
                                NeedFunction().makeCall(
                                    controller.userinfo.value.mobileNo ?? "",
                                    donordata.mobileNumber ?? "");
                              }, "Call"),
                              Container(
                                width: 1.w,
                                height: 25.h,
                                color: AppColors.primaryGrey,
                              ),
                              infoBtn(() {
                                Get.toNamed(AppRouters.chatpage,
                                    arguments: {'donor': donordata});
                              }, "Message"),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ));
  }
}
