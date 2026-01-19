import 'dart:async';
import 'package:donorjunctionhub/model/hospital_model.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/routers/routers.dart';
import 'package:donorjunctionhub/values/mapfunction.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:donorjunctionhub/widgets/msg_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  late Timer timer;

  Rx<HospitalDetails> hospitalDetails = HospitalDetails().obs;
  final LocalAuthentication authentication = LocalAuthentication();

  getUserDetailes() async {
    await Mapfunction().onLocation();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    if (id == null) {
      timer = Timer(const Duration(seconds: 2), () {
        Get.toNamed(AppRouters.welcome);
      });
    } else {
      var reslut =
          await NetworkHandler.get("${AppString.baseUrl}myDetails/$id");
      if (reslut['success']) {
        HospitalModel hospitalModel = HospitalModel.fromJson(reslut);
        hospitalDetails.value = hospitalModel.data!;
        if (hospitalDetails.value.hospitalName == "") {
          timer = Timer(const Duration(seconds: 2), () {
            Get.toNamed(AppRouters.registration);
          });
        } else {
          if (hospitalDetails.value.status == "1") {
            timer = Timer(const Duration(seconds: 2), () {
              Get.toNamed(AppRouters.bottombar);
            });
          } else {
            Get.dialog(
              barrierDismissible: false,
              PopScope(
                canPop: false,
                child: Dialog(
                  backgroundColor: Colors.transparent,
                  child: MsgInfo(
                    msg: 'Still Your document verification is in progress.',
                  ),
                ),
              ),
            );
          }
        }
      } else {}
    }
  }

  Future<void> authenticate() async {
    try {
      bool authenticated = await authentication.authenticate(
          localizedReason: "DonorJunction",
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: false,
          ));
      if (authenticated) {
        getUserDetailes();
      }
    } catch (e) {
      debugPrint("$e");
    }
  }

  fingerLockCheck() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool lockON = preferences.getBool("finger") ?? false;
    if (lockON) {
      authenticate();
    } else {
      getUserDetailes();
    }
  }

  @override
  void onInit() {
    fingerLockCheck();
    super.onInit();
  }
}
