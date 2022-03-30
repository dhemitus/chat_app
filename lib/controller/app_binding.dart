import 'package:get/get.dart';
import 'package:chatapp/controller/controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TinodeController>(TinodeController(), permanent: true);
    Get.put<AppController>(AppController(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<UserController>(UserController(), permanent: true);
  }
}