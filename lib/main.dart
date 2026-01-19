import 'package:donorjunctionhub/api/dependency_injection.dart';
import 'package:donorjunctionhub/api/firebase_api.dart';
import 'package:donorjunctionhub/firebase_options.dart';
import 'package:donorjunctionhub/routers/routers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        builder: FToastBuilder(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        getPages: AppRouters().appRouters,
        initialRoute: AppRouters.splash,
      ),
    );
  }
}
