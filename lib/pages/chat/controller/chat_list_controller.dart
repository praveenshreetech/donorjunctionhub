import 'package:donorjunctionhub/model/alldonorsmodel.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/pages/chat/model/chat_list_model.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatListController extends GetxController {
  RxBool isloading = false.obs;
  RxList<ChatListData> chatList = <ChatListData>[].obs;
  Rx<DonorData> donor = DonorData().obs;
  RxList<DonorData> chatDonors = <DonorData>[].obs;

  getChatList() async {
    isloading(true);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('id');
    var results = await NetworkHandler.post(
        {'id': "$id"}, "${AppString.chatURI}/get_Hospital_Chat_List");
    if (results['status'] == 200) {
      ChatListModel chatListModel = ChatListModel.fromJson(results);
      chatList.value = chatListModel.data ?? [];
      chatDonors.clear();
      for (var i = 0; i < chatList.length; i++) {
        getchatuserdata(chatList[i].receiverId ?? "");
      }
      isloading(false);
    } else {
      chatList.value = [];
      isloading(false);
    }
  }

  getchatuserdata(String id) async {
    var results =
        await NetworkHandler.get("${AppString.baseUrl}getDonorDet/$id");

    if (results['success']) {
      donor.value = DonorData.fromJson(results['data']);
      chatDonors.add(donor.value);
    }
  }

  @override
  void onInit() {
    getChatList();
    super.onInit();
  }
}
