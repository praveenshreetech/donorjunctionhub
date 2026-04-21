import 'package:donorjunctionhub/model/alldonorsmodel.dart';
import 'package:donorjunctionhub/model/hospital_model.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class DlistController extends GetxController {
  Location location = Location();
  RxString bloodShow = "All".obs;
  Rx<HospitalDetails> userinfo = HospitalDetails().obs;
  RxList<DonorData> alllist = <DonorData>[].obs;
  RxList<DonorData> donorslist = <DonorData>[].obs;
  RxDouble cLat = 0.0.obs;
  RxDouble cLng = 0.0.obs;
  RxBool isloading = false.obs;

  bool _canShowDonorForUser(DonorData donor) {
    if (donor.bloodGroup == null) {
      return false;
    }

    final userState = userinfo.value.state?.trim() ?? '';
    final donorState = donor.state?.trim() ?? '';

    if (userState.isEmpty) {
      return true;
    }

    return donorState == userState;
  }

  getAlldonor() async {
    isloading(true);
    userinfo = await NeedFunction().getLoginUserDetails();
    var result = await NetworkHandler.get("${AppString.baseUrl}getAllDonor");
    if (result['success']) {
      AllDonorsModel allDonorsModel = AllDonorsModel.fromJson(result);
      alllist.value = allDonorsModel.data ?? [];
      donorslist.clear();
      for (var i = 0; i < alllist.length; i++) {
        if (_canShowDonorForUser(alllist[i])) {
          donorslist.add(alllist[i]);
        }
      }
      isloading(false);
    } else {
      donorslist.clear();
      isloading(false);
    }
  }

  flitterblood() async {
    isloading(true);
    userinfo = await NeedFunction().getLoginUserDetails();
    var result = await NetworkHandler.post({"blood_group": bloodShow.value},
        "${AppString.baseUrl}search_by_blood");
    if (result['success']) {
      AllDonorsModel allDonorsModel = AllDonorsModel.fromJson(result);
      alllist.value = allDonorsModel.data ?? [];
      donorslist.clear();
      for (var i = 0; i < alllist.length; i++) {
        if (_canShowDonorForUser(alllist[i])) {
          donorslist.add(alllist[i]);
        }
      }

      isloading(false);
    } else {
      donorslist.clear();
      isloading(false);
    }
  }

  @override
  void onInit() {
    getAlldonor();
    super.onInit();
  }
}
