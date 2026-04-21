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
    try {
      await Mapfunction().onLocation().timeout(
        const Duration(seconds: 5),
        onTimeout: () {},
      );
    } catch (e) {
      debugPrint('Location error: $e');
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var id = prefs.getString("id");
      if (id == null) {
        _goToWelcome();
        return;
      }

      var reslut = await NetworkHandler.get("${AppString.baseUrl}myDetails/$id");
      if (reslut['success']) {
        HospitalModel hospitalModel = HospitalModel.fromJson(reslut);
        hospitalDetails.value = hospitalModel.data!;
        if (hospitalDetails.value.hospitalName == "") {
          timer = Timer(const Duration(seconds: 2), () {
            Get.toNamed(AppRouters.registration);
          });
        } else if (hospitalDetails.value.status == "1") {
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
      } else {
        _navigateOffline(id);
      }
    } catch (e) {
      debugPrint('Splash error: $e');
      _goToWelcome();
    }
  }

  void _navigateOffline(String? id) {
    if (id != null && id.isNotEmpty) {
      timer = Timer(const Duration(seconds: 2), () {
        Get.toNamed(AppRouters.bottombar);
      });
      return;
    }

    _goToWelcome();
  }

  void _goToWelcome() {
    timer = Timer(const Duration(seconds: 2), () {
      Get.toNamed(AppRouters.welcome);
    });
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

  @override
  void onClose() {
    try {
      timer.cancel();
    } catch (_) {}
    super.onClose();
  }
}



// import 'dart:async';
// import 'package:donorjunctionhub/model/hospital_model.dart';
// import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
// import 'package:donorjunctionhub/routers/routers.dart';
// import 'package:donorjunctionhub/values/mapfunction.dart';
// import 'package:donorjunctionhub/values/strings.dart';
// import 'package:donorjunctionhub/widgets/msg_info.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SplashController extends GetxController {
//   late Timer timer;
  
//   Rx<HospitalDetails> hospitalDetails = HospitalDetails().obs;
//   final LocalAuthentication authentication = LocalAuthentication();

//   getUserDetailes() async {
//     try {
//       // ✅ location with timeout
//       await Mapfunction().onLocation().timeout(
//         const Duration(seconds: 5),
//         onTimeout: () {},
//       );
//     } catch (e) {
//       debugPrint('Location error: $e');
//       // continue even if location fails
//     }

//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       var id = prefs.getString("id");

//       if (id == null) {
//         // ✅ no id = go to welcome
//         timer = Timer(const Duration(seconds: 2), () {
//           Get.toNamed(AppRouters.welcome);
//         });
//         return;
//       }

//       // ✅ try API call
//       try {
//         var reslut = await NetworkHandler.get(
//           "${AppString.baseUrl}myDetails/$id",
//         );

//         if (reslut['success']) {
//           HospitalModel hospitalModel = HospitalModel.fromJson(reslut);
//           hospitalDetails.value = hospitalModel.data!;

//           if (hospitalDetails.value.hospitalName == "") {
//             timer = Timer(const Duration(seconds: 2), () {
//               Get.toNamed(AppRouters.registration);
//             });
//           } else {
//             if (hospitalDetails.value.status == "1") {
//               timer = Timer(const Duration(seconds: 2), () {
//                 Get.toNamed(AppRouters.bottombar);
//               });
//             } else {
//               Get.dialog(
//                 barrierDismissible: false,
//                 PopScope(
//                   canPop: false,
//                   child: Dialog(
//                     backgroundColor: Colors.transparent,
//                     child: MsgInfo(
//                       msg: 'Still Your document verification is in progress.',
//                     ),
//                   ),
//                 ),
//               );
//             }
//           }
//         } else {
//           // ✅ API returned false — go to welcome
//           _goToWelcome();
//         }

//       } catch (e) {
//         // ✅ API failed (no internet/server down) — use saved login
//         debugPrint('API error: $e');
//         _navigateOffline(id);
//       }

//     } catch (e) {
//       // ✅ SharedPreferences failed — go to welcome
//       debugPrint('Prefs error: $e');
//       _goToWelcome();
//     }
//   }

//   // ✅ When backend offline but user was logged in before
//   void _navigateOffline(String? id) {
//     if (id != null && id.isNotEmpty) {
//       // user was logged in before → go to home
//       timer = Timer(const Duration(seconds: 2), () {
//         Get.toNamed(AppRouters.bottombar);
//       });
//     } else {
//       _goToWelcome();
//     }
//   }

//   void _goToWelcome() {
//     timer = Timer(const Duration(seconds: 2), () {
//       Get.toNamed(AppRouters.welcome);
//     });
//   }

//   Future<void> authenticate() async {
//     try {
//       bool authenticated = await authentication.authenticate(
//         localizedReason: "DonorJunction",
//         options: const AuthenticationOptions(
//           stickyAuth: true,
//           biometricOnly: false,
//         ),
//       );
//       if (authenticated) {
//         getUserDetailes();
//       } else {
//         // ✅ auth failed or cancelled — still navigate
//         _goToWelcome();
//       }
//     } catch (e) {
//       debugPrint("Auth error: $e");
//       // ✅ auth error — still navigate
//       getUserDetailes();
//     }
//   }

//   fingerLockCheck() async {
//     try {
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       bool lockON = preferences.getBool("finger") ?? false;
//       if (lockON) {
//         authenticate();
//       } else {
//         getUserDetailes();
//       }
//     } catch (e) {
//       debugPrint('fingerLockCheck error: $e');
//       getUserDetailes(); // ✅ fallback
//     }
//   }

//   @override
//   void onInit() {
//     fingerLockCheck();
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     // ✅ cancel timer to avoid memory leaks
//     try { timer.cancel(); } catch (_) {}
//     super.onClose();
//   }
// }
