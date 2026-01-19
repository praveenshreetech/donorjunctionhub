import 'dart:io';

import 'package:donorjunctionhub/model/hospital_model.dart';
import 'package:donorjunctionhub/networkhendler/network_hendler.dart';
import 'package:donorjunctionhub/pages/blog/model/new_blog_model.dart';
import 'package:donorjunctionhub/pages/home/controller/home_controller.dart';
import 'package:donorjunctionhub/pages/userblog/controller/user_blog_controller.dart';
import 'package:donorjunctionhub/values/needfunction.dart';
import 'package:donorjunctionhub/values/strings.dart';
import 'package:donorjunctionhub/widgets/upload_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewBlogConroller extends GetxController {
  var userblogcontroller = Get.find<UserBlogController>();
  var homecontroller = Get.find<HomeController>();
  Rx<HospitalDetails> hospitalDetails = HospitalDetails().obs;
  RxString uploadimges = ''.obs;
  RxInt picterindex = 0.obs;
  TextEditingController datecontroller = TextEditingController();
  TextEditingController contactcontroller = TextEditingController();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descrController = TextEditingController();
  RxString postType = 'Select Blog Type'.obs;

  pickImages() async {
    ImagePicker imagePicker = ImagePicker();

    XFile? images = await imagePicker.pickImage(source: ImageSource.gallery);

    if (images == null) {
      return;
    }
    uploadimges.value = images.path;
  }

  postNewBlog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id");
    hospitalDetails = await NeedFunction().getLoginUserDetails();
    if (titlecontroller.text.trim().isEmpty) {
      NeedFunction.toastmsg('Please enter the post title.');
    } else if (contactcontroller.text.trim().isEmpty) {
      NeedFunction.toastmsg('Please enter the contact mobile number.');
    } else if (datecontroller.text.trim().isEmpty) {
      NeedFunction.toastmsg('Please select the event date.');
    } else if (postType.value == "Select Blog Type") {
      NeedFunction.toastmsg('Please select the post type.');
    } else if (uploadimges.value == '') {
      NeedFunction.toastmsg('Please select the post Image.');
    } else {
      Get.dialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        Dialog(
          child: UploadDialog(),
        ),
      );
      NewBlogModel newBlogModel = NewBlogModel(
        h_id: id.toString(),
        category: postType.value,
        title: titlecontroller.text.trim(),
        date: datecontroller.text.trim(),
        contact_number: contactcontroller.text.trim(),
        lat: hospitalDetails.value.latitude ?? "",
        long: hospitalDetails.value.longitude ?? "",
        description: descrController.text.trim(),
        images: File(uploadimges.value),
      );
      var reslut = await NetworkHandler.post(
          await newBlogModel.tomap(), "${AppString.baseUrl}addpost");

      if (reslut['success']) {
        NeedFunction.toastmsg('Upload successfully.');
        uploadimges.value = '';
        picterindex.value = 0;
        datecontroller.clear();
        contactcontroller.clear();
        descrController.clear();
        titlecontroller.clear();
        postType.value = 'Select Blog Type';
        userblogcontroller.bloglist.clear();
        userblogcontroller.getAllBlog();
        homecontroller.getAllBlog();
        Get.back();
        Get.back();
      } else {
        NeedFunction.toastmsg('Something went wrong. Please try again.');
        Get.back();
      }
    }
  }
}
