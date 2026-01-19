import 'package:donorjunctionhub/pages/chat/controller/chat_list_controller.dart';
import 'package:donorjunctionhub/pages/chat/widget/chat_widget.dart';
import 'package:donorjunctionhub/routers/routers.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ChatList extends StatelessWidget {
  ChatList({super.key});
  var chatlistController = Get.put(ChatListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatListAppBar(),
      body: Obx(
        () => chatlistController.isloading.value
            ? Loader()
            : chatlistController.chatDonors.isEmpty
                ? Center(
                    child: Text(
                      "No chat list in your account.",
                      style: NeedFunction.fontstyle(TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 14.sp)),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        Column(
                          children: List.generate(
                              chatlistController.chatDonors.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRouters.chatpage, arguments: {
                                  'donor': chatlistController.chatDonors[index]
                                });
                              },
                              child: chatListContainer(
                                  chatlistController.chatDonors[index]),
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
