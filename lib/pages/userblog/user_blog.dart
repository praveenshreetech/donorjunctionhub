import 'package:donorjunctionhub/pages/blog/widget/blogwidget.dart';
import 'package:donorjunctionhub/pages/userblog/controller/user_blog_controller.dart';
import 'package:donorjunctionhub/pages/userblog/widget/user_blog_widget.dart';
import 'package:donorjunctionhub/routers/routers.dart';
import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/images.dart';
import 'package:donorjunctionhub/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class UserBlog extends StatelessWidget {
  UserBlog({super.key});
  var userblogcontroller = Get.put(UserBlogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarywhite,
      appBar: userBlogTopBar(),
      body: Obx(() => Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              Expanded(
                child: userblogcontroller.isloading.value
                    ? Center(child: Loader())
                    : userblogcontroller.bloglist.isEmpty
                        ? Container(
                            width: Get.width,
                            height: Get.height,
                            color:
                                AppColors.lightTextColor.withValues(alpha: 0.5),
                            child: Center(
                              child: Image.asset(AppImages.noData),
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                  userblogcontroller.bloglist.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRouters.blogdetails,
                                        arguments: {
                                          'blog':
                                              userblogcontroller.bloglist[index]
                                        });
                                  },
                                  child: blogContainer(
                                      userblogcontroller.bloglist[index],
                                      userblogcontroller.hospitalDetails.value),
                                );
                              }),
                            ),
                          ),
              )
            ],
          )),
    );
  }
}
