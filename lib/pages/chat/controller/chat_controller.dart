import 'dart:async';
import 'package:donorjunctionhub/model/alldonorsmodel.dart';
import 'package:donorjunctionhub/model/hospital_model.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/pages/chat/model/chat_send_model.dart';
import 'package:donorjunctionhub/pages/chat/model/message_list_model.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatController extends GetxController {
  Rx<DonorData> donor = DonorData().obs;
  Rx<HospitalDetails> hospitalDetails = HospitalDetails().obs;
  RxBool isLoading = false.obs;
  RxList<MessagesList> messagesList = <MessagesList>[].obs;
  TextEditingController messagecontroller = TextEditingController();

  late Timer timer;

  getAllMSG() async {
    isLoading(true);
    hospitalDetails = await NeedFunction().getLoginUserDetails();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    ChatsendModel chatsendModel =
        ChatsendModel(sid: "$id", rid: donor.value.id ?? "", sendertype: 'h');
    var results = await NetworkHandler.post(
        chatsendModel.tomap(), '${AppString.chatURI}get_Messages');
    if (results['status'] == 200) {
      MessageLIstModel messageLIstModel = MessageLIstModel.fromJson(results);
      messagesList.value = messageLIstModel.data ?? [];
      isLoading(false);
    } else {
      messagesList.value = [];
      isLoading(false);
    }
  }

  meassageCheck() async {
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => getAllMSG());
  }

  sendmessage() async {
    if (messagecontroller.text.trim().isEmpty) {
      NeedFunction.toastmsg("Please enter your message.");
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var id = prefs.getString("id");
      ChatsendModel chatsendModel = ChatsendModel(
          sid: "$id",
          sendertype: 'h',
          rid: donor.value.id ?? "",
          message: messagecontroller.text.trim());
      var results = await NetworkHandler.post(
          chatsendModel.tomap(), "${AppString.chatURI}chat_for_post_publisher");
      if (results['status'] == 200) {
        getAllMSG();
        messagecontroller.text = "";
      } else {
        NeedFunction.toastmsg('Something went wrong. Please try again.');
      }
    }
  }

  @override
  void onInit() {
    donor.value = Get.arguments['donor'];
    getAllMSG();
    meassageCheck();
    super.onInit();
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }
}
