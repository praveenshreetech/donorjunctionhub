import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/pages/blog/model/all_blog_model.dart';
import 'package:donorjunctionhub/pages/home/controller/home_controller.dart';
import 'package:donorjunctionhub/pages/notification/model/notification_model.dart';
import 'package:donorjunctionhub/routers/routers.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  RxList<NotificationList> notificationList = <NotificationList>[].obs;
  RxBool isloadiong = false.obs;
  var homecontroller = Get.find<HomeController>();
  Rx<BlogData> blogview = BlogData().obs;

  getAllNotification() async {
    isloadiong(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    var result =
        await NetworkHandler.get("${AppString.baseUrl}/getMyNotification/$id");

    if (result['success']) {
      NotificationModel notificationModel = NotificationModel.fromJson(result);
      notificationList.value = notificationModel.data ?? [];
      isloadiong(false);
    } else {
      isloadiong(false);
    }
  }

  viewnotification(NotificationList notification) async {
    var result = await NetworkHandler.get(
        "${AppString.baseUrl}viewMyNotification/${notification.id}/${notification.postId}");
    if (result['success']) {
      if (notification.status == '0') {
        homecontroller.notiCount = homecontroller.notiCount - 1;
      }
      blogview.value = BlogData.fromJson(result['data']);
      Get.toNamed(AppRouters.blogdetails, arguments: {'blog': blogview.value});
    } else {
      NeedFunction.toastmsg('Something went wrong. Please try again.');
    }
  }

  @override
  void onInit() {
    getAllNotification();
    super.onInit();
  }
}
