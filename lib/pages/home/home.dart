import 'package:donorjunctionhub/pages/home/controller/home_controller.dart';
import 'package:donorjunctionhub/pages/home/widget/homewidget.dart';
import 'package:donorjunctionhub/routers/routers.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/mapfunction.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});
  var homecontroller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: AppColors.primarywhite,
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              homecontroller.isloading.value
                  ? Container()
                  : topBar(homecontroller.userDetails.value, () {
                      Get.toNamed(AppRouters.notification);
                    }, homecontroller.notiCount.value),
              homecontroller.isloading.value
                  ? Container()
                  : slider(homecontroller.bloglist),
              SizedBox(
                height: 30.h,
              ),
              Expanded(
                child: Container(
                  width: Get.width,
                  color: AppColors.lightTextColor.withValues(alpha: 0.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      Row(
                        children: [
                          categoryContainer(() async {
                            bool isuser = await NeedFunction().gusetcheck();
                            if (isuser) {
                              NeedFunction.toastmsg(
                                  "You are in a guest account. Please log in. ");
                            } else {
                              Get.toNamed(AppRouters.userblog);
                            }
                          }, AppImages.campaigns, 'Campaigns'),
                          categoryContainer(() {
                            Get.toNamed(AppRouters.chatlist);
                          }, AppImages.chat, 'Chat'),
                          categoryContainer(() async {
                            bool onlocation = await Mapfunction().onLocation();
                            if (onlocation) {
                              Get.toNamed(AppRouters.mapview);
                            }
                          }, AppImages.finddonor, 'Find Donor'),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 25.w),
                      //   child: Text(
                      //     'Donation Requests',
                      //     style: NeedFunction.fontstyle(
                      //       TextStyle(
                      //           fontWeight: FontWeight.w900,
                      //           color: AppColors.primaryblock,
                      //           fontSize: 12.sp),
                      //     ),
                      //   ),
                      // ),
                      // donationCard()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
