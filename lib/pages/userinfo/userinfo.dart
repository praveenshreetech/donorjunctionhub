import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/pages/userinfo/controller/user_controller.dart';
import 'package:donorjunctionhub/pages/userinfo/userwidget.dart';
import 'package:donorjunctionhub/routers/routers.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class UserInfo extends StatelessWidget {
  UserInfo({super.key});
  var userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                AppImages.profileBg,
              ),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 60.h,
            ),
            CircleAvatar(
              radius: 50.r,
              backgroundImage: NetworkImage(
                NetworkHandler.buildImageUrl(
                    "${userController.userinfo.value.id}/${userController.userinfo.value.hospitalImages}"),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Text(
              "${userController.userinfo.value.hospitalName} ${userController.userinfo.value.category}",
              style: NeedFunction.fontstyle(
                TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: AppColors.primaryblock),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                countCard(
                    AppImages.infoCard1, "${userController.totleblog}", "Blog"),
                SizedBox(
                  width: 20.w,
                ),
                countCard(AppImages.infoCard2, "0", "Donors"),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    btnInfo(AppImages.donor, 'Donors', () async {
                      bool isuser = await NeedFunction().gusetcheck();
                      if (isuser) {
                        NeedFunction.toastmsg(
                            "You are in a guest account. Please log in. ");
                      } else {
                        Get.toNamed(AppRouters.donorlist);
                      }
                    }),
                    btnInfo(AppImages.blog, 'Blog', () async {
                      bool isuser = await NeedFunction().gusetcheck();
                      if (isuser) {
                        NeedFunction.toastmsg(
                            "You are in a guest account. Please log in. ");
                      } else {
                        Get.toNamed(AppRouters.userblog);
                      }
                    }),
                    btnInfo(AppImages.chat, 'Chat', () {
                      Get.toNamed(AppRouters.chatlist);
                    }),
                    btnInfoIcon(Icons.settings_outlined, "Settings", () {
                      Get.toNamed(AppRouters.setting);
                    })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
