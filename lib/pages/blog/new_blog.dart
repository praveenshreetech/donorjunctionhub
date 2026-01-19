import 'package:donorjunctionhub/pages/blog/widget/newblog_widget.dart';
import 'package:donorjunctionhub/pages/userblog/controller/new_blog_conroller.dart';

import 'package:donorjunctionhub/values/colors.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/widgets/btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class NewBlog extends StatelessWidget {
  NewBlog({super.key});
  var blogcontroller = Get.put(NewBlogConroller());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              blogcontroller.uploadimges = ''.obs;
              blogcontroller.picterindex.value = 0;
              blogcontroller.datecontroller.clear();
              blogcontroller.contactcontroller.clear();
              blogcontroller.descrController.clear();
              blogcontroller.titlecontroller.clear();
              blogcontroller.postType.value = 'Select Blog Type';
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColors.primaryblock,
            ),
          ),
          title: Text(
            'Create Blog',
            style: NeedFunction.fontstyle(
              TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: AppColors.primaryblock),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              blogTextfield('Title', blogcontroller.titlecontroller,
                  TextInputType.text, 1000),
              imagepickerview(blogcontroller),
              SizedBox(
                height: 10.h,
              ),
              descriptionWidget('Description', blogcontroller.descrController),
              blogTextfield('Contact Number', blogcontroller.contactcontroller,
                  TextInputType.number, 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Row(
                  children: [
                    Expanded(
                      child:
                          postdatepick(context, blogcontroller.datecontroller),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    dropdown(blogcontroller),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              BTN(
                  ontap: () {
                    blogcontroller.postNewBlog();
                  },
                  name: 'Post',
                  bgcolor: AppColors.primaryColor),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
