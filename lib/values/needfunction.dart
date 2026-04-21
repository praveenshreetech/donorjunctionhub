import 'package:donorjunctionhub/model/alldonorsmodel.dart';
import 'package:donorjunctionhub/model/hospital_model.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NeedFunction {
  DateTime? lastpressed;

  static fontstyle(TextStyle style) {
    return GoogleFonts.inter(textStyle: style);
  }

  static toastmsg(String msg) {
    return Fluttertoast.showToast(
        backgroundColor: AppColors.primaryColor,
        textColor: AppColors.primarywhite,
        gravity: ToastGravity.CENTER,
        msg: msg);
  }

  getLoginUserDetails() async {
    Rx<HospitalDetails> hospitalDetails = HospitalDetails().obs;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    if (id != null) {
      var result =
          await NetworkHandler.get("${AppString.baseUrl}myDetails/$id");
      if (result['success']) {
        HospitalModel hospitalModel = HospitalModel.fromJson(result);
        hospitalDetails.value = hospitalModel.data!;
      }
    }
    return hospitalDetails;
  }

  bloodreadyImg(String date) {
    DateTime tempDate = DateFormat("MM-dd-yyyy").parse(date);

    final birthday = DateTime(tempDate.year, tempDate.month, tempDate.day);
    final date2 = DateTime.now();
    final difference = date2.difference(birthday).inDays;
    final pre = difference / 90 * 100;
    int redy = pre.round();

    return redy > 90 ? AppImages.ready : AppImages.notready;
  }

  bloodreadyStr(String date) {
    DateTime tempDate = DateFormat("MM-dd-yyyy").parse(date);
    final birthday = DateTime(tempDate.year, tempDate.month, tempDate.day);
    final date2 = DateTime.now();
    final difference = date2.difference(birthday).inDays;
    final pre = difference / 90 * 100;
    int redy = pre.round();
    return redy > 90 ? "Ready" : "NotReady";
  }

  getDonorDetails(String id) async {
    Rx<DonorData> donordata = DonorData().obs;
    var result =
        await NetworkHandler.get("${AppString.baseUrl}getDonorDet/$id");
    if (result['success']) {
      donordata.value = DonorData.fromJson(result['data']);
      return donordata;
    }
  }

  makeCall(String usernumber, String tonumber) async {
    await NetworkHandler.get(
        "${AppString.baseUrl}connect_my_call/$usernumber/$tonumber");
  }

  getLocationInAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    double lat = locations.first.latitude;
    double lon = locations.first.longitude;
    return LatLng(lat, lon);
  }

  String blogDate(String date) {
    DateTime parseDate = DateFormat("dd-MM-yyyy").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd MMM');
    var outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  Future<bool> gusetcheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    if (id == "1") {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> getLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("id");
  }
}
