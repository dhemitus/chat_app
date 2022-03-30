import 'package:get/get.dart';
import 'package:chatapp/data/data.dart';
import 'package:chatapp/controller/controller.dart';

class AppController extends GetxController {
  RxBool isAuth = false.obs;
  RxBool isLoading = true.obs;
  AuthService auth = AuthService.instance;

  @override
  void onInit() {
    super.onInit();
    print(this.isAuth.value);
    appInit();

  }

  void appInit() async {
    print('============ app on INIT');
    isAuth.value = await auth.session();
    this.isLoading.value = false;
    await goToLandingPage(this.isAuth.value);
  }

  goToLandingPage(bool authCheck) async {
    if (authCheck) {
      print('session on');
      await Get.find<TinodeController>().login();

//      Get.offAllNamed('/chat');
    } else {
      print('session off');
//      Get.offAllNamed('/signIn');
    }
  }

  @override
  void onReady() {
    print('============ app controller on READY');
    super.onReady();
  }
}
