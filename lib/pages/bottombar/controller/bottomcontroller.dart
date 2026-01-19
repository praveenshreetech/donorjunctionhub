import 'package:donorjunctionhub/pages/home/home.dart';
import 'package:donorjunctionhub/pages/userblog/user_blog.dart';
import 'package:donorjunctionhub/pages/userinfo/userinfo.dart';
import 'package:get/get.dart';

class BottomController extends GetxController {
  RxInt tapindex = 1.obs;

  RxList page = [
    UserBlog(),
    Home(),
    UserInfo(),
  ].obs;
}
