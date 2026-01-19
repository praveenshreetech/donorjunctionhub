import 'package:donorjunctionhub/pages/blog/new_blog.dart';
import 'package:donorjunctionhub/pages/bottombar/bottombar.dart';
import 'package:donorjunctionhub/pages/chat/chat_list.dart';
import 'package:donorjunctionhub/pages/chat/chat_page.dart';
import 'package:donorjunctionhub/pages/donorslist/donor_list.dart';
import 'package:donorjunctionhub/pages/login/done.dart';
import 'package:donorjunctionhub/pages/login/mobilenumber.dart';
import 'package:donorjunctionhub/pages/login/otpverification.dart';
import 'package:donorjunctionhub/pages/login/welcome.dart';
import 'package:donorjunctionhub/pages/logout/logout.dart';
import 'package:donorjunctionhub/pages/map_view/map_view.dart';
import 'package:donorjunctionhub/pages/notification/notification.dart';
import 'package:donorjunctionhub/pages/registration/registration.dart';
import 'package:donorjunctionhub/pages/settings/settings.dart';
import 'package:donorjunctionhub/pages/splash/splash.dart';
import 'package:donorjunctionhub/pages/termsand_privacy/termsand_privacy.dart';
import 'package:donorjunctionhub/pages/userblog/blog_details.dart';
import 'package:donorjunctionhub/pages/userblog/user_blog.dart';
import 'package:get/get.dart';

class AppRouters {
  static String splash = '/splash';
  static String getsplash() => splash;

  static String welcome = '/welcome';
  static String getwelcome() => welcome;

  static String mobile = '/mobile';
  static String getmobile() => mobile;

  static String otp = '/otp';
  static String getotp() => otp;

  static String done = '/done';
  static String getdone() => done;

  static String bottombar = '/bottombar';
  static String getbottombar() => bottombar;

  static String registration = '/registration';
  static String getregistration() => registration;

  static String donorlist = '/donorlist';
  static String getdonorlist() => donorlist;

  static String mapview = '/mapview';
  static String getmapview() => mapview;

  static String addblog = '/addblog';
  static String getaddblog() => addblog;

  static String userblog = '/userblog';
  static String getuserblog() => userblog;

  static String blogdetails = '/blogdetails';
  static String getblogdetails() => blogdetails;

  static String chatlist = '/chatlist';
  static String getchatlist() => chatlist;

  static String chatpage = '/chatpage';
  static String getchatpage() => chatpage;

  static String notification = '/notification';
  static String getnotification() => notification;

  static String termsandprivacy = '/termsandprivacy';
  static String gettermsandprivacy() => termsandprivacy;

  static String logout = '/logout';
  static String getlogout() => logout;

  static String setting = '/setting';
  static String getsetting() => setting;

  List<GetPage> appRouters = [
    GetPage(
      name: splash,
      page: () => Splash(),
    ),
    GetPage(
      name: welcome,
      page: () => Welcome(),
    ),
    GetPage(
      name: mobile,
      page: () => MobileNumber(),
    ),
    GetPage(
      name: otp,
      page: () => OtpVerification(),
    ),
    GetPage(
      name: done,
      page: () => const Done(),
    ),
    GetPage(
      name: bottombar,
      page: () => BottomBar(),
    ),
    GetPage(
      name: registration,
      page: () => Registration(),
    ),
    GetPage(
      name: donorlist,
      page: () => DonorList(),
    ),
    GetPage(
      name: mapview,
      page: () => ViewMap(),
    ),
    GetPage(
      name: addblog,
      page: () => NewBlog(),
    ),
    GetPage(
      name: userblog,
      page: () => UserBlog(),
    ),
    GetPage(
      name: blogdetails,
      page: () => BlogDetails(),
    ),
    GetPage(
      name: chatlist,
      page: () => ChatList(),
    ),
    GetPage(
      name: chatpage,
      page: () => ChatPage(),
    ),
    GetPage(
      name: notification,
      page: () => Notification(),
    ),
    GetPage(
      name: termsandprivacy,
      page: () => TermsandPrivacy(),
    ),
    GetPage(
      name: logout,
      page: () => Logout(),
    ),
    GetPage(
      name: setting,
      page: () => Settings(),
    ),
  ];
}
