import 'package:donorjunctionhub/pages/donorslist/controller/dlist_controller.dart';
import 'package:donorjunctionhub/pages/donorslist/widget/donorwidget.dart';
import 'package:donorjunctionhub/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DonorList extends StatelessWidget {
  DonorList({super.key});
  var dlistcontroller = Get.put(DlistController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => dlistcontroller.isloading.value
          ? const Loader()
          : Scaffold(
              appBar: bar(),
              body: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: dlistcontroller.donorslist.length,
                        itemBuilder: (context, index) {
                          return DonorContainer(
                            controller: dlistcontroller,
                            donordata: dlistcontroller.donorslist[index],
                          );
                        }),
                  ),
                ],
              ),
              bottomNavigationBar: bottomfitter(dlistcontroller),
            ),
    );
  }
}
