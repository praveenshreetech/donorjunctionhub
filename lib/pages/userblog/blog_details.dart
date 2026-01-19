import 'package:donorjunctionhub/pages/userblog/controller/blog_details_controller.dart';
import 'package:donorjunctionhub/pages/userblog/widget/blog_details_widget.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BlogDetails extends StatelessWidget {
  BlogDetails({super.key});
  var blogdetailscontroller = Get.put(BlogDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: blogDetailsAppBar(),
      body: Obx(
        () => blogdetailscontroller.isLoading.value
            ? Loader()
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      blogDetails(blogdetailscontroller.hospitalDetails.value,
                          blogdetailscontroller.blogdata.value),
                      SizedBox(
                        height: 15.h,
                      ),
                      blogdetailscontroller.postRequest.isEmpty
                          ? Column(
                              children: [
                                Text(
                                  "No donor has yet come forward to donate blood for your post.",
                                  style: NeedFunction.fontstyle(TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp,
                                  )),
                                ),
                                Image.asset(
                                  AppImages.noReq,
                                ),
                              ],
                            )
                          : Column(
                              children: List.generate(
                                  blogdetailscontroller.postRequest.length,
                                  (index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 5.0.h),
                                  child: ReqPending(
                                    id: blogdetailscontroller
                                            .postRequest[index].donorId ??
                                        "",
                                    controller: blogdetailscontroller,
                                    postRequest: blogdetailscontroller
                                        .postRequest[index],
                                  ),
                                );
                              }),
                            ),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
