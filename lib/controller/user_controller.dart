import 'package:get/get.dart';
import 'package:chatapp/data/data.dart';

class UserController extends GetxController {
  RxString userId = ''.obs;
  final UserService api = UserService.instance;

  Future<void> getUser(String id) async {
    try {
      final UserProfile? _user = await api.getUser(id);
    } catch (e) {
      print(e);
    }
  }
}
