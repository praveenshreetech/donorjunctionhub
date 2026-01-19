import 'package:donorjunctionhub/pages/chat/controller/chat_controller.dart';
import 'package:donorjunctionhub/pages/chat/widget/chat_widget.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  var chatcontroller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBody: true,
        appBar: chatAppBar(
            chatcontroller.donor.value, chatcontroller.hospitalDetails.value),
        body: Container(
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 10.h),
          color: AppColors.bgColor.withValues(alpha: 0.5),
          child: Column(
            children: [
              chatcontroller.messagesList.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(
                          "No messages yet.",
                          style: NeedFunction.fontstyle(TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: AppColors.primaryColor)),
                        ),
                      ),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              chatcontroller.messagesList.length, (index) {
                            return messageWidget(
                                chatcontroller.messagesList[index].senderType ==
                                    'h',
                                chatcontroller.messagesList[index].message ??
                                    "");
                          }),
                        ),
                      ),
                    ),
              chatBox(chatcontroller.messagecontroller, () {
                chatcontroller.sendmessage();
              })
            ],
          ),
        ),
      ),
    );
  }
}
