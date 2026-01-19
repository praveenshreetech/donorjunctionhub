import 'package:donorjunctionhub/pages/notification/controller/notification_controller.dart';
import 'package:donorjunctionhub/pages/notification/widget/notification_widget.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Notification extends StatelessWidget {
  Notification({super.key});
  var notifiactionController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            "Notification",
            style: NeedFunction.fontstyle(
              TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
            ),
          ),
        ),
        body: notifiactionController.isloadiong.value
            ? Loader()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      children: List.generate(
                          notifiactionController.notificationList.length,
                          (index) {
                        return GestureDetector(
                          onTap: () {
                            notifiactionController.viewnotification(
                                notifiactionController.notificationList[index]);
                          },
                          child: notificationCondainer(
                              notifiactionController.notificationList[index]),
                        );
                      }),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
