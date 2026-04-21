import 'dart:async';
import 'dart:convert';
import 'package:donorjunctionhub/model/alldonorsmodel.dart';
import 'package:donorjunctionhub/model/hospital_model.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/mapfunction.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class MapController extends GetxController {
  Location location = Location();
  Rx<HospitalDetails> hospitalDetails = HospitalDetails().obs;
  Rx<CameraPosition> currentPosition =
      const CameraPosition(target: LatLng(11.127123, 78.656891), zoom: 15).obs;
  RxBool isLoading = false.obs;

  Completer<GoogleMapController> googlemapcontroller =
      Completer<GoogleMapController>();
  RxList<Marker> markers = <Marker>[].obs;
  RxList placelist = [].obs;
  RxList<DonorData> alldonorslist = <DonorData>[].obs;

  TextEditingController placeController = TextEditingController();

  var mapCircle = <Circle>{}.obs;

  bool _matchesUserState(DonorData donor) {
    final userState = hospitalDetails.value.state?.trim() ?? '';
    final donorState = donor.state?.trim() ?? '';

    if (userState.isEmpty) {
      return true;
    }

    return donorState == userState;
  }

  checkpermission() async {
    isLoading(true);
    LatLng? locationData = await Mapfunction().getCurrentLocation();
    if (locationData != null) {
      currentPosition.value = CameraPosition(
          target: LatLng(locationData.latitude, locationData.longitude),
          zoom: 12.7);
      markers.clear();
      mapCircle.clear();
      markers.add(
        Marker(
          markerId: const MarkerId('you'),
          position: LatLng(locationData.latitude, locationData.longitude),
          // ignore: deprecated_member_use
          icon: BitmapDescriptor.fromBytes(
            await Mapfunction().getImages(AppImages.uLocation),
          ),
        ),
      );
      mapCircle.add(
        Circle(
            circleId: const CircleId("cl"),
            radius: 5000,
            strokeColor: AppColors.primaryblock.withValues(alpha: 0.2),
            strokeWidth: 1.w.toInt(),
            center: LatLng(locationData.latitude, locationData.longitude),
            fillColor: AppColors.primaryblock.withValues(alpha: 0.2)),
      );
      update();
      getAlldonors(LatLng(locationData.latitude, locationData.longitude));
      isLoading(false);
    } else {
      isLoading(false);
    }
  }

  onmapcreated(GoogleMapController controller) {
    googlemapcontroller.complete(controller);
  }

  getAlldonors(LatLng crl) async {
    hospitalDetails = await NeedFunction().getLoginUserDetails();
    var result = await NetworkHandler.get("${AppString.baseUrl}getAllDonor");
    if (result['success']) {
      AllDonorsModel allDonorsModel = AllDonorsModel.fromJson(result);
      alldonorslist.value = allDonorsModel.data ?? [];
      for (var i = 0; i < alldonorslist.length; i++) {
        if (_matchesUserState(alldonorslist[i]) &&
            alldonorslist[i].latitude != null &&
            alldonorslist[i].lastDonate != null) {
          double lat = double.parse(alldonorslist[i].latitude ?? "00.0");
          double lan = double.parse(alldonorslist[i].longitude ?? "00.0");
          double dis = Mapfunction()
              .calculateDistance(crl.latitude, crl.longitude, lat, lan);
          if (dis < 5000) {
            String id = alldonorslist[i].id ?? i.toString();
            Marker resultMarker = Marker(
              markerId: MarkerId(alldonorslist[i].id ?? i.toString()),
              position: LatLng(lat, lan),
              infoWindow: InfoWindow(snippet: id),
              onTap: () async {
                // Rx<DonorData> donordata = DonorData().obs;
                // donordata = await NeedFunction()
                //     .getDonorDetails(alldonorslist[i].id ?? "");
                // Get.bottomSheet(
                //   backgroundColor: Colors.transparent,
                //   userBottomBar(donordata.value),
                // );
              },

              // ignore: deprecated_member_use
              icon: BitmapDescriptor.fromBytes(
                await Mapfunction().getImages(AppImages.dLocation),
              ),
            );
            markers.add(resultMarker);
          }
        }
      }
    }
  }

  void getSuggestion(String input) async {
    String placeapikey = AppString.mapKey;
    String baseURL =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request = "$baseURL?input=$input&key=$placeapikey";
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      placelist.value = jsonDecode(response.body.toString())['predictions'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  scarchAdreess(String address) async {
    isLoading(true);
    LatLng location = await NeedFunction().getLocationInAddress(address);

    currentPosition.value = CameraPosition(
        target: LatLng(location.latitude, location.longitude), zoom: 12.7);

    markers.clear();
    mapCircle.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('you'),
        position: LatLng(location.latitude, location.longitude),
        // ignore: deprecated_member_use
        icon: BitmapDescriptor.fromBytes(
          await Mapfunction().getImages(AppImages.uLocation),
        ),
      ),
    );
    mapCircle.add(
      Circle(
          circleId: const CircleId("cl"),
          radius: 5000,
          strokeColor: AppColors.primaryblock.withValues(alpha: 0.2),
          strokeWidth: 1.w.toInt(),
          center: LatLng(location.latitude, location.longitude),
          fillColor: AppColors.primaryblock.withValues(alpha: 0.2)),
    );
    update();
    getAlldonors(LatLng(location.latitude, location.longitude));
    isLoading(false);
  }

  @override
  void onInit() {
    checkpermission();
    super.onInit();
  }
}
