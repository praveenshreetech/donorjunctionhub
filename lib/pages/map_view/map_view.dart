import 'package:donorjunctionhub/pages/map_view/map_controller.dart';
import 'package:donorjunctionhub/pages/map_view/widget/map_widget.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class ViewMap extends StatelessWidget {
  ViewMap({super.key});
  var mapcontroller = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Find Donors",
          style: NeedFunction.fontstyle(
            TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ),
      ),
      body: Container(
          width: Get.width,
          height: Get.height,
          color: Colors.white,
          child: Obx(
            () => Stack(
              children: [
                mapcontroller.isLoading.value
                    ? const Loader()
                    : GoogleMap(
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: true,
                        circles: mapcontroller.mapCircle,
                        markers: Set<Marker>.of(mapcontroller.markers),
                        initialCameraPosition:
                            mapcontroller.currentPosition.value,
                        onMapCreated: mapcontroller.onmapcreated,
                      ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    height: 50.h,
                    color: AppColors.primarywhite,
                    child: Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller: mapcontroller.placeController,
                          onChanged: (value) {
                            mapcontroller.getSuggestion(value);
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                              hintStyle: NeedFunction.fontstyle(TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12.sp,
                                  color: AppColors.lightTextColor))),
                        )),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            mapcontroller.checkpermission();
                            mapcontroller.placeController.text = "";
                          },
                          child: Icon(
                            Icons.location_on,
                            color: AppColors.primaryColor,
                            size: 25.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50.h,
                  child: Visibility(
                    visible: mapcontroller.placelist.isNotEmpty,
                    child: placelist(mapcontroller.placelist, mapcontroller),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
