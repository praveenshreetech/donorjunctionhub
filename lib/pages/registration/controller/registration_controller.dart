import 'dart:io';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/pages/registration/model/registra_model.dart';
import 'package:donorjunctionhub/values/mapfunction.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:donorjunctionhub/widgets/msg_info.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationController extends GetxController {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController licensenumbercontroller = TextEditingController();
  RxString category = 'select organization category'.obs;
  RxString documentname = 'License Document'.obs;
  RxString orgImage = 'Organization Image'.obs;
  RxBool namedone = false.obs;
  RxBool maildone = false.obs;
  RxBool cadone = false.obs;
  RxBool licdone = false.obs;
  RxBool docdone = false.obs;
  RxBool btnEnble = false.obs;
  RxBool orgImagedone = false.obs;
  RxBool addressDone = false.obs;
  RxString orgAddress = 'Click here to get your company address.'.obs;
  RxString orgPincode = "".obs;
  RxString orgLat = "".obs;
  RxString orgLon = "".obs;
  RxString orgState = "".obs;
  RxString orgCountry = "".obs;
  RxString orgcity = "".obs;
  RxString orgLinceImg = ''.obs;
  RxString orgProfileImg = ''.obs;

  validationcheck() {
    if (namecontroller.text.trim().length >= 4) {
      namedone(true);
    } else {
      namedone(false);
    }
    if (GetUtils.isEmail(mailcontroller.text.trim())) {
      maildone(true);
    } else {
      maildone(false);
    }
    if (licensenumbercontroller.text.trim().length >= 3) {
      licdone(true);
    } else {
      licdone(false);
    }
    if (namedone.value &&
        maildone.value &&
        licdone.value &&
        cadone.value &&
        licdone.value &&
        orgImagedone.value &&
        addressDone.value) {
      btnEnble(true);
    } else {
      btnEnble(false);
    }
  }

  pickdocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'pdf', 'doc', 'jpg']);

    if (result != null) {
      File file = File(result.files.single.path!);
      orgLinceImg.value = file.path;
      documentname.value = file.path.split('/').last;
      docdone(true);
      OpenFile.open(file.path);
      validationcheck();
    } else {
      docdone(false);
      validationcheck();
      // User canceled the picker
    }
  }

  pickOrgImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      orgImage.value = file.path.split('/').last;
      orgProfileImg.value = file.path;
      orgImagedone(true);
      validationcheck();
    } else {
      orgImagedone(false);
      validationcheck();
      // User canceled the picker
    }
  }

  getaddress() async {
    final LatLng latLng = await Mapfunction().getCurrentLocation();
    orgLat.value = latLng.latitude.toString();
    orgLon.value = latLng.longitude.toString();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    orgAddress.value =
        "${placemarks[0].subThoroughfare},${placemarks[1].street},${placemarks[1].locality},${placemarks[1].thoroughfare},${placemarks[2].locality},${placemarks[1].administrativeArea},${placemarks[1].country},${placemarks[1].postalCode}.";
    orgPincode.value = "${placemarks[1].postalCode}";
    orgState.value = "${placemarks[1].administrativeArea}";
    orgCountry.value = "${placemarks[1].country}";
    orgcity.value = "${placemarks[2].locality}";
    addressDone(true);
  }

  orgRegistration() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var id = preferences.getString('id');
    if (btnEnble.value) {
      RegistraModel registraModel = RegistraModel(
        h_id: "$id",
        hospital_name: namecontroller.text.trim(),
        category: category.value,
        hospital_email: mailcontroller.text.trim(),
        address: orgAddress.value,
        license_no: licensenumbercontroller.text.trim(),
        city: orgcity.value,
        country: orgCountry.value,
        state: orgState.value,
        latitude: orgLat.value,
        longitude: orgLon.value,
        pincode: orgPincode.value,
        license_img: File(orgLinceImg.value),
        profile_img: File(orgProfileImg.value),
      );
      var response = await NetworkHandler.post(
          await registraModel.tomap(), "${AppString.baseUrl}update_my_detail");

      if (response['success']) {
        Get.dialog(
          barrierDismissible: false,
          PopScope(
            canPop: false,
            child: Dialog(
              backgroundColor: Colors.transparent,
              child: MsgInfo(
                  msg:
                      'Registration is complete. We will verify your document and then activate your account.'),
            ),
          ),
        );
      } else {
        NeedFunction.toastmsg("Something went wrong. Please try again.");
      }
    } else {
      NeedFunction.toastmsg('Please provide the required details.');
    }
  }
}
