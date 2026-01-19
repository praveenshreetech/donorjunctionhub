import 'package:donorjunctionhub/pages/termsand_privacy/termsand_privacy_controller.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class TermsandPrivacy extends StatelessWidget {
  TermsandPrivacy({super.key});
  var tpController = Get.put(TermsandPrivacyController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: Get.width,
        height: Get.height,
        color: AppColors.primarywhite,
        child: tpController.pross.value
            ? WebViewWidget(controller: tpController.controller)
            : const Loader(),
      ),
    );
  }
}
