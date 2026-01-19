import 'package:card_swiper/card_swiper.dart';
import 'package:donorjunctionhub/model/hospital_model.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/pages/blog/model/all_blog_model.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget topBar(HospitalDetails user, VoidCallback ontap, int nodi) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "WELCOME",
              style: NeedFunction.fontstyle(TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 12.sp,
                  color: AppColors.textColor)),
            ),
            Text(
              "${user.hospitalName} ${user.category}",
              style: NeedFunction.fontstyle(TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16.sp,
                  color: AppColors.primaryblock)),
            ),
          ],
        ),
        GestureDetector(
          onTap: ontap,
          child: SizedBox(
            width: 50.w,
            height: 50.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.notifications_outlined,
                  size: 30.sp,
                  color: AppColors.primaryblock,
                ),
                Positioned(
                  top: 15.h,
                  left: 15.w,
                  child: Visibility(
                    visible: nodi != 0,
                    child: Container(
                      width: 10.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

class Slider extends StatefulWidget {
  const Slider({super.key, required this.blist});
  final BlogData blist;

  @override
  State<Slider> createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  @override
  void initState() {
    getposthospital();
    super.initState();
  }

  Rx<HospitalDetails> userDetails = HospitalDetails().obs;
  getposthospital() async {
    var result = await NetworkHandler.get(
        "${AppString.baseUrl}myDetails/${widget.blist.hospitalId}");

    if (result['success']) {
      HospitalModel hospitalModel = HospitalModel.fromJson(result);
      userDetails.value = hospitalModel.data!;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          width: Get.width,
          height: 170.h,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
              color: AppColors.lightTextColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10.r)),
          child: Row(
            children: [
              Image.network(
                NetworkHandler.buildImageUrl(
                    "${widget.blist.hospitalId}/${widget.blist.image}"),
                width: 125.w,
                height: 125.h,
              ),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "${userDetails.value.hospitalName ?? ""} ${userDetails.value.category ?? ""}",
                    style: NeedFunction.fontstyle(
                      TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16.sp,
                          color: AppColors.primaryblock),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    widget.blist.category ?? "",
                    style: NeedFunction.fontstyle(
                      TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: AppColors.primaryblock),
                    ),
                  ),
                  Text(
                    widget.blist.description ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: NeedFunction.fontstyle(
                      TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: AppColors.primaryblock),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 62.w,
                    height: 23.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryblock,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Center(
                      child: Text(
                        NeedFunction().blogDate(widget.blist.campDate == ""
                            ? widget.blist.campDate ?? DateTime.now().toString()
                            : DateTime.now().toString()),
                        style: NeedFunction.fontstyle(
                          TextStyle(
                              fontWeight: FontWeight.w900,
                              color: AppColors.primarywhite,
                              fontSize: 10.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ));
  }
}

Widget slider(RxList<BlogData> blist) {
  return SizedBox(
    width: Get.width,
    height: 170.h,
    child: Swiper(
      autoplay: true,
      itemCount: blist.length,
      itemBuilder: (context, index) {
        return Slider(
          blist: blist[index],
        );
      },
    ),
  );
}

Widget categoryContainer(
  VoidCallback ontap,
  String image,
  String title,
) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.w),
    child: GestureDetector(
      onTap: ontap,
      child: Container(
        width: 90.w,
        height: 90.h,
        decoration: BoxDecoration(
          color: AppColors.primarywhite,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 40.w,
              height: 40.h,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              title,
              style: NeedFunction.fontstyle(
                TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 8.sp,
                    color: AppColors.primaryblock),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget donationCard() {
  return Container(
    width: 290.w,
    height: 90.h,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    child: Swiper(
      itemCount: 5,
      autoplay: true,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            width: 290.w,
            height: 90.h,
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      radius: 30.r,
                      backgroundImage: const NetworkImage(
                          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=1760&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          "Akshey Kumar",
                          style: NeedFunction.fontstyle(TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 12.sp,
                              color: AppColors.primaryblock)),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              AppImages.location,
                              width: 15.w,
                              height: 15.h,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "Chennai, India",
                              style: NeedFunction.fontstyle(
                                TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp,
                                    color: AppColors.primaryblock),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: 25.r,
                  child: Text(
                    "O+",
                    style: NeedFunction.fontstyle(
                      TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14.sp,
                          color: AppColors.primarywhite),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    ),
  );
}
