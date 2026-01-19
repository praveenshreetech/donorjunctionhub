import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity connectivity = Connectivity();

  @override
  void onInit() {
    connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    super.onInit();
  }

  void updateConnectionStatus(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.none)) {
      Get.dialog(
          barrierDismissible: false,
          Dialog(
            backgroundColor: Colors.transparent,
            child: PopScope(
                canPop: false,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "No Internet Connection",
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ),
                      Divider(
                        color: AppColors.primaryColor,
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        AppImages.noNetwork,
                        height: 300,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Divider(
                        color: AppColors.primaryColor,
                        thickness: 1,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Please check your connection.",
                          style: TextStyle(color: AppColors.primaryColor),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )),
          ));
    } else {
      Get.back();
    }
  }
}
