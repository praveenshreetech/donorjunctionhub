import 'dart:async';

import 'package:donorjunctionhub/model/hospital_model.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/pages/blog/model/all_blog_model.dart';
import 'package:donorjunctionhub/pages/notification/model/notification_model.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  RxBool isloading = false.obs;
  RxList<BlogData> bloglist = <BlogData>[].obs;
  RxList<NotificationList> notificationList = <NotificationList>[].obs;
  Rx<HospitalDetails> userDetails = HospitalDetails().obs;
  RxInt notiCount = 0.obs;
  late Timer timer;

  getAllBlog() async {
    isloading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    userDetails = await NeedFunction().getLoginUserDetails();
    var result = await NetworkHandler.get('${AppString.baseUrl}getMyPost/$id');
    if (result['success']) {
      AllBlogModel blogModel = AllBlogModel.fromJson(result);
      bloglist.value = blogModel.data ?? [];
      getAllNotification();
      isloading(false);
    } else {
      isloading(false);
    }
  }

  checkNotification() async {
    timer = Timer.periodic(
        const Duration(seconds: 5), (Timer t) => getAllNotification());
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  getAllNotification() async {
    notiCount.value = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    var result =
        await NetworkHandler.get("${AppString.baseUrl}/getMyNotification/$id");

    if (result['success']) {
      NotificationModel notificationModel = NotificationModel.fromJson(result);
      notificationList.value = notificationModel.data ?? [];
      for (var i = 0; i < notificationList.length; i++) {
        if (notificationList[i].status == '0') {
          notiCount = notiCount + 1;
        }
      }
    } else {}
  }

  @override
  void onInit() {
    getAllBlog();
    checkNotification();
    super.onInit();
  }
}
