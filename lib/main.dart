import 'package:chatapp/modules/modules.dart';
import 'package:chatapp/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:chatapp/controller/controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await GetStorage.init();

  runApp(const StartApp());
}

class StartApp extends StatelessWidget {
  const StartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialBinding: AppBinding(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: const Color(0xFFF7F7F7),
        ),
        home: SplashPage(),
        getPages: AppRoutes.pageRoutes,
      )
    );
  }
}