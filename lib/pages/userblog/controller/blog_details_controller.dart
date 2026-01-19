import 'dart:async';

import 'package:donorjunctionhub/model/alldonorsmodel.dart';
import 'package:donorjunctionhub/model/hospital_model.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/pages/blog/model/all_blog_model.dart';
import 'package:donorjunctionhub/pages/userblog/model/action_req_model.dart';
import 'package:donorjunctionhub/pages/userblog/model/donat_req_model.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:get/get.dart';

class BlogDetailsController extends GetxController {
  Rx<BlogData> blogdata = BlogData().obs;
  Rx<HospitalDetails> hospitalDetails = HospitalDetails().obs;
  RxBool isLoading = false.obs;
  Rx<DonorData> donor = DonorData().obs;
  RxList<PostRequest> postRequest = <PostRequest>[].obs;
  late Timer timer;

  getPostRequest() async {
    hospitalDetails = await NeedFunction().getLoginUserDetails();

    var results = await NetworkHandler.get(
        "${AppString.baseUrl}getMypostRequestDetail/${blogdata.value.id}");

    if (results['success']) {
      DonatReqModel donatReqModel = DonatReqModel.fromJson(results);
      postRequest.value = donatReqModel.data ?? [];
    } else {
      isLoading(false);
    }
  }

  getDonorDertailes(String id) async {
    var results =
        await NetworkHandler.get("${AppString.baseUrl}getDonorDet/$id");

    if (results['success']) {
      donor.value = DonorData.fromJson(results['data']);
      return donor.value;
    }
  }

  actionforReq(String pId, String dID, String action) async {
    ActionReqModel actionReqModel =
        ActionReqModel(p_id: pId, d_id: dID, action: action);
    var results = await NetworkHandler.post(await actionReqModel.tomap(),
        "${AppString.baseUrl}actionforRequestedDonors");
    if (results['success']) {
      getPostRequest();
    } else {
      NeedFunction.toastmsg('Something went wrong. Please try again.');
    }
  }

  checkRequest() async {
    timer = Timer.periodic(
        const Duration(seconds: 5), (Timer t) => getPostRequest());
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    blogdata.value = Get.arguments['blog'];
    checkRequest();
    super.onInit();
  }
}
