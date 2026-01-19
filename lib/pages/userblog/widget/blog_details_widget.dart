import 'package:donorjunctionhub/model/alldonorsmodel.dart';
import 'package:donorjunctionhub/model/hospital_model.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/pages/blog/model/all_blog_model.dart';
import 'package:donorjunctionhub/pages/userblog/controller/blog_details_controller.dart';
import 'package:donorjunctionhub/pages/userblog/model/donat_req_model.dart';
import 'package:donorjunctionhub/routers/routers.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

AppBar blogDetailsAppBar() {
  return AppBar(
    title: Text(
      "Blog Details",
      style: NeedFunction.fontstyle(
        TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryblock,
            fontSize: 20.sp),
      ),
    ),
  );
}

Widget blogDetails(HospitalDetails hdata, BlogData bdata) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                    NetworkHandler.buildImageUrl(
                        "${hdata.id}/${hdata.hospitalImages}"),
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            "${hdata.hospitalName ?? ""} ${hdata.category ?? ""}",
            style: NeedFunction.fontstyle(
                TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
          )
        ],
      ),
      SizedBox(
        height: 15.h,
      ),
      Container(
        width: Get.width,
        height: 300.h,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          image: DecorationImage(
              image: NetworkImage(
                NetworkHandler.buildImageUrl("${hdata.id}/${bdata.image}"),
              ),
              fit: BoxFit.cover),
        ),
      ),
      SizedBox(
        height: 15.h,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bdata.category ?? "",
              style: NeedFunction.fontstyle(
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "${bdata.title} ${bdata.description}",
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              style: NeedFunction.fontstyle(
                  TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp)),
            ),
          ],
        ),
      )
    ],
  );
}

class ReqPending extends StatefulWidget {
  const ReqPending(
      {super.key,
      required this.id,
      required this.controller,
      required this.postRequest});
  final String id;
  final BlogDetailsController controller;
  final PostRequest postRequest;

  @override
  State<ReqPending> createState() => _ReqPendingState();
}

class _ReqPendingState extends State<ReqPending> {
  @override
  void initState() {
    getdonor();
    super.initState();
  }

  getdonor() async {
    donor.value = await widget.controller.getDonorDertailes(widget.id);
  }

  Rx<DonorData> donor = DonorData().obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() => donor.value.name == null
        ? Container()
        : widget.postRequest.status == 'request'
            ? Container(
                width: Get.width,
                height: 150.h,
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightTextColor),
                    borderRadius: BorderRadius.circular(30.r)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: donor.value.image == ''
                                        ? AssetImage(AppImages.userimage)
                                        : NetworkImage(NetworkHandler.buildImageUrl(
                                            'donors/${widget.id}/${donor.value.image}')),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  donor.value.name ?? "",
                                  style: NeedFunction.fontstyle(
                                    TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
                                  ),
                                ),
                                Text(
                                  "I am happy to donate...",
                                  style: NeedFunction.fontstyle(
                                    TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.sp,
                                        color: AppColors.lightTextColor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            optionBtn(Icons.call, () async {
                              NeedFunction().makeCall(
                                  widget.controller.hospitalDetails.value
                                          .mobileNo ??
                                      "",
                                  donor.value.mobileNumber ?? "");
                            }),
                            SizedBox(
                              height: 5.h,
                            ),
                            optionBtn(Icons.message, () {
                              Get.toNamed(AppRouters.chatpage,
                                  arguments: {'donor': donor.value});
                            }),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              widget.controller.actionforReq(
                                  widget.postRequest.postId ?? "",
                                  widget.id,
                                  'rejected');
                            },
                            child: Container(
                              height: 45.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r),
                                  border: Border.all(
                                      color: AppColors.primaryblock,
                                      width: 2.w)),
                              child: Center(
                                child: Text(
                                  "Didn't donate",
                                  style: NeedFunction.fontstyle(
                                    TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              widget.controller.actionforReq(
                                  widget.postRequest.postId ?? "",
                                  widget.id,
                                  'complete');
                            },
                            child: Container(
                              height: 45.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.r),
                                  color: AppColors.primaryColor),
                              child: Center(
                                child: Text(
                                  "Donated",
                                  style: NeedFunction.fontstyle(
                                    TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: AppColors.primarywhite),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            : reqComplete(donor.value));
  }
}

Widget optionBtn(IconData icon, VoidCallback ontap) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      width: 38,
      height: 29,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.primaryColor),
      child: Icon(
        icon,
        color: AppColors.primarywhite,
        size: 18.sp,
      ),
    ),
  );
}

Widget reqComplete(DonorData donor) {
  return Container(
    width: Get.width,
    height: 74.h,
    padding: EdgeInsets.all(12.r),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.r),
      border: Border.all(color: AppColors.primaryGreen),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: donor.image == ''
                        ? AssetImage(AppImages.userimage)
                        : NetworkImage(NetworkHandler.buildImageUrl(
                            'donors/${donor.id}/${donor.image}')),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  donor.name ?? "",
                  style: NeedFunction.fontstyle(
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
                  ),
                ),
                Text(
                  "Completed",
                  style: NeedFunction.fontstyle(
                    TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: AppColors.primaryGreen),
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          width: 30.w,
          height: 30.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryGreen, width: 3),
          ),
          child: Center(
            child: Icon(
              Icons.check,
              color: AppColors.primaryGreen,
              size: 20.sp,
            ),
          ),
        )
      ],
    ),
  );
}
