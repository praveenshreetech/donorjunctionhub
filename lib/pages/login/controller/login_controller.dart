import 'dart:async';
import 'package:donorjunctionhub/api/firebase_api.dart';
import 'package:donorjunctionhub/model/hospital_model.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/pages/login/controller/smsauto.dart';
import 'package:donorjunctionhub/pages/login/model/login_models.dart';
import 'package:donorjunctionhub/routers/routers.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:donorjunctionhub/widgets/msg_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_auth/smart_auth.dart';

class LoginController extends GetxController {
  RxBool tc = false.obs;
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();
  RxInt secondsRemaining = 30.obs;

  Rx<HospitalDetails> hospitadetails = HospitalDetails().obs;
  late Timer timer;
  SmsRetriever? smsRetriever; // ✅ Changed to nullable to prevent LateInitializationErrors

  String get normalizedMobileNumber =>
      numbercontroller.text.replaceAll(RegExp(r'[^0-9]'), '').trim();

  mobilenumberpage() {
    if (tc.value) {
      Get.toNamed(AppRouters.mobile);
    } else {
      NeedFunction.toastmsg(
          "Please agree to our terms of use and privacy policy.");
    }
  }

  sendotp(bool onNext) async {
    String fcmkey = "";
    try {
      fcmkey = await FirebaseApi().initNotifications();
    } catch (e) {
      debugPrint('FCM init failed during login: $e');
    }

    if (normalizedMobileNumber.length == 10) {
      MobileNumberModel mobileNumberModel = MobileNumberModel(
          mobileNo: normalizedMobileNumber, fcm_key: fcmkey);
      var result = await NetworkHandler.post(
          mobileNumberModel.tomap(), "login");

      if (result['success']) {
        NeedFunction.toastmsg(result['message'] ?? 'OTP Sent');
        secondsRemaining.value = 30;
        _cancelTimerIfRunning();

        resendtime();
        if (onNext) {
          smsRetriever = SmsRetrieverImpl(
            SmartAuth(),
          );
          Get.toNamed(AppRouters.otp);
        }
      } else {
        NeedFunction.toastmsg(result['message'] ?? 'Unable to send OTP. Please try again.');
      }
    } else {
      NeedFunction.toastmsg('Mobile number must be 10 digits.');
    }
  }

  otpverifi() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (otpcontroller.text.trim().length < 4) {
      NeedFunction.toastmsg('OTP must be 4 characters.');
    } else {
      OTPModel otpModel = OTPModel(
          mobileNo: normalizedMobileNumber,
          otp: otpcontroller.text.trim());
      var result = await NetworkHandler.post(
          otpModel.tomap(), "otp_verification");
      if (result['success']) {
        HospitalModel hospitalModel = HospitalModel.fromJson(result);
        
        // ✅ Added null check for hospital data
        if (hospitalModel.data != null) {
          hospitadetails.value = hospitalModel.data!;
          pref.setString("id", hospitadetails.value.id ?? "");
          
          if (hospitadetails.value.hospitalName == "") {
            Get.toNamed(AppRouters.registration);
          } else {
            if (hospitadetails.value.status == '1') {
              Get.toNamed(AppRouters.done);
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
        } else {
          NeedFunction.toastmsg('Login successful but no user data found.');
        }
      } else {
        NeedFunction.toastmsg(
            _buildErrorMessage(result, 'OTP verification failed.'));
      }
    }
  }

  resendtime() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining.value != 0) {
        secondsRemaining.value = secondsRemaining.value - 1;
      } else {
        _cancelTimerIfRunning();
      }
    });
  }

  String _buildErrorMessage(
      Map<String, dynamic> result, String fallbackMessage) {
    final message = (result['message'] ?? '').toString().trim();
    if (message.isNotEmpty &&
        message != 'null' &&
        message != 'Unexpected server response' &&
        message != 'Invalid server response') {
      return message;
    }

    final status = result['status'];
    if (status != null && status.toString() != '0') {
      return '$fallbackMessage (status: $status)';
    }

    return fallbackMessage;
  }

  void _cancelTimerIfRunning() {
    try {
      timer.cancel();
    } catch (_) {}
  }

  @override
  void onClose() {
    _cancelTimerIfRunning();
    super.onClose();
  }
}
