import 'package:donorjunctionhub/routers/routers.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController extends GetxController {
  logoutUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("id");
    Get.offAllNamed(AppRouters.welcome);
  }
}
