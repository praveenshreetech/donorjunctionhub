import 'package:donorjunctionhub/model/hospital_model.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/pages/blog/model/all_blog_model.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBlogController extends GetxController {
  RxList<BlogData> bloglist = <BlogData>[].obs;
  RxBool isloading = false.obs;
  Rx<HospitalDetails> hospitalDetails = HospitalDetails().obs;

  getAllBlog() async {
    isloading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    hospitalDetails = await NeedFunction().getLoginUserDetails();
    var result = await NetworkHandler.get('${AppString.baseUrl}getMyPost/$id');
    if (result['success']) {
      AllBlogModel blogModel = AllBlogModel.fromJson(result);
      bloglist.value = blogModel.data ?? [];
      isloading(false);
    } else {
      isloading(false);
    }
  }

  @override
  void onInit() {
    getAllBlog();
    super.onInit();
  }
}
