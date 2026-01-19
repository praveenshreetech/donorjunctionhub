import 'package:donorjunctionhub/pages/blog/blog_controller.dart';
import 'package:donorjunctionhub/pages/blog/widget/blogwidget.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Blog extends StatelessWidget {
  Blog({super.key});
  var blogcontroller = Get.put(BlogController());

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.primarywhite,
        child: Obx(
          () => Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              topbar(),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: blogcontroller.isloading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : blogcontroller.bloglist.isEmpty
                        ? Container(
                            width: Get.width,
                            height: Get.height,
                            color:
                                AppColors.lightTextColor.withValues(alpha: 0.3),
                            child: Center(
                              child: Image.asset(AppImages.noData),
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                  blogcontroller.posthospitals.length, (index) {
                                return blogContainer(
                                    blogcontroller.bloglist[index],
                                    blogcontroller.posthospitals[index]);
                              }),
                            ),
                          ),
              )
            ],
          ),
        ));
  }
}
