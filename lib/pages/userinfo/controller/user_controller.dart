import 'package:donorjunctionhub/model/hospital_model.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/pages/blog/model/all_blog_model.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  Rx<HospitalDetails> userinfo = HospitalDetails().obs;
  RxList<BlogData> bloglist = <BlogData>[].obs;
  RxInt totleblog = 0.obs;

  getuserinfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    userinfo = await NeedFunction().getLoginUserDetails();
    var reslut = await NetworkHandler.get("${AppString.baseUrl}getMyPost/$id");
    if (reslut['success']) {
      AllBlogModel blogModel = AllBlogModel.fromJson(reslut);
      bloglist.value = blogModel.data ?? [];
      totleblog.value = bloglist.length;
    } else {}
  }

  @override
  void onInit() {
    getuserinfo();
    super.onInit();
  }
}
