import 'package:donorjunctionhub/model/hospital_model.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/pages/blog/model/all_blog_model.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:get/get.dart';

class BlogController extends GetxController {
  RxList<BlogData> bloglist = <BlogData>[].obs;
  RxList<HospitalDetails> posthospitals = <HospitalDetails>[].obs;
  Rx<HospitalDetails> hospitalDetails = HospitalDetails().obs;

  RxBool isloading = false.obs;

  getAllBlog() async {
    isloading(true);
    var result = await NetworkHandler.get('${AppString.baseUrl}getAllPost');
    if (result['success']) {
      AllBlogModel blogModel = AllBlogModel.fromJson(result);
      bloglist.value = blogModel.data ?? [];
      posthospitals.clear();
      for (var i = 0; i < bloglist.length; i++) {
        getposthospital(bloglist[i].hospitalId ?? "");
      }
      isloading(false);
    } else {
      isloading(false);
    }
  }

  getposthospital(String id) async {
    var result = await NetworkHandler.get("${AppString.baseUrl}myDetails/$id");

    if (result['success']) {
      HospitalModel hospitalModel = HospitalModel.fromJson(result);
      posthospitals.add(hospitalModel.data!);
    } else {}
  }

  @override
  void onInit() {
    getAllBlog();
    super.onInit();
  }
}
