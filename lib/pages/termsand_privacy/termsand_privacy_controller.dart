import 'package:donorjunctionhub/values/colors.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsandPrivacyController extends GetxController {
  late final WebViewController controller;
  RxString id = ''.obs;
  RxBool pross = false.obs;

  loadview() async {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.primarywhite)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            pross(true);
          },
          onWebResourceError: (error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse("http://192.168.1.55/donorjunction_full/donorjunction_api/Termsandprivacy.html"));
  }

  @override
  void onInit() {
    loadview();
    super.onInit();
  }
}
