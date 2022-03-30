import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:chatapp/data/data.dart';
import 'package:chatapp/controller/controller.dart';

class AuthController extends GetxController {
  RxBool isAuth = false.obs;
  RxBool hide = true.obs;

  AuthService auth = AuthService.instance;

  @override
  void onInit() {
    super.onInit();
    print('init auth');

    isAuth.value = true;
  }

  Future<bool> session() async {
    try {
      return await auth.session();
//      return true;
    } catch (e) {
      return false;
    }
  }

  Future<OnLogin> login(
      {required String userId, required String password}) async {
    late OnLogin result;
    try {
      result = await auth.signIn(userId, password);
      print(result);
      if (result == OnLogin.notFirst) {
        //await Get.find<TinodeController>().login();
        await Get.find<UserController>().getUser(userId);
        Get.offAllNamed('/home');
      } else if (result == OnLogin.first) {
        Get.offAllNamed('/resetPassword');
      } else {
        Get.snackbar(
          "Error Login",
          "username or password is incorrect",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on DioError catch (e) {
      Get.snackbar(
        "Error Login",
        e.response!.data['response_message'],
        snackPosition: SnackPosition.BOTTOM,
      );
      result = OnLogin.failed;
    }

    return result;
  }

  Future<bool> logOut() async {
    bool result = false;
    await auth.signOut();
    try {
      Get.snackbar(
        "Bye bye",
        "Have a nice day",
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.offAllNamed('/signIn');
    } catch (e) {
      Get.snackbar(
        "Error logout",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return result;
  }

  Map<String, dynamic> getRoles(String param) {
    return auth.getRoles(param);
  }
}
