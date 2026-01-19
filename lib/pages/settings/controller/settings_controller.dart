import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  final LocalAuthentication authentication = LocalAuthentication();
  final Location location = Location();

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  RxBool isSupportSate = false.obs;
  RxBool fingerprintlock = false.obs;
  RxBool notificationON = true.obs;
  RxBool onLocation = false.obs;

  fingerCheck() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    fingerprintlock.value = preferences.getBool("finger") ?? false;

    onLocation.value = await location.serviceEnabled();
    Timer.periodic(const Duration(seconds: 2), (Timer t) async {
      onLocation.value = await location.serviceEnabled();
    });
    authentication.isDeviceSupported().then((onValue) {
      isSupportSate.value = onValue;
    });
  }

  Future<void> getAvailableBiometrics() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (isSupportSate.value) {
      List<BiometricType> availbleBiometrics =
          await authentication.getAvailableBiometrics();
      debugPrint("List of availableBiometrics : $availbleBiometrics");
      if (availbleBiometrics.isEmpty) {
        NeedFunction.toastmsg("please enable biometric login in settings.");
      } else {
        fingerprintlock.value = !fingerprintlock.value;
        if (fingerprintlock.value) {
          preferences.setBool("finger", true);
        } else {
          preferences.setBool("finger", false);
        }
      }
    } else {
      fingerprintlock.value = false;
      NeedFunction.toastmsg("Fingerprint lock not supported on your mobile.");
    }
  }

  stopNotification() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? id = preferences.getString("id");
    // if (notificationON.value) {
    //   await messaging.deleteToken();
    //   notificationON.value = false;
    //   preferences.setBool("noti", false);
    // } else {
    //   await messaging.requestPermission();
    //   String? fcm = await messaging.getToken();
    //   FcmModel fcmModel = FcmModel(
    //       address: "",
    //       country: "",
    //       state: "",
    //       city: "",
    //       latitude: "",
    //       longitude: "",
    //       pincode: "",
    //       donor_id: "$id",
    //       fcm_key: "$fcm");
    //   var result = await NetworkHandler.post(await fcmModel.tomap(),
    //       "${AppString.baseUrl}update_fcm_location_det");
    //   if (result['success']) {
    //     notificationON.value = true;
    //     preferences.setBool("noti", true);
    //   } else {
    //     NeedFunction.toastmsg('Something went wrong. Please try again');
    //   }
    // }
  }

  stopLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (serviceEnabled) {
      AppSettings.openAppSettings(type: AppSettingsType.location);
    } else {
      await location.requestService();
    }
  }

  @override
  void onInit() {
    fingerCheck();
    super.onInit();
  }
}
