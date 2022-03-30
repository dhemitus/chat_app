import 'dart:io';
import 'package:chatapp/utils/utils.dart';
import 'package:chatapp/data/data.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:chatapp/controller/controller.dart';

class UserService {
  static UserService get instance => UserService._();

  final Dio _dio = Dio();

  final GetStorage _record = GetStorage();

  UserService._();


  Future<UserProfile?> getUser(String id) async {
    String? _session = _record.read('session');
    print('record token');

    UserSession _user = UserSession.fromJson(_session!);

    // print("Token ${_user.token}");
    var token = JwtDecoder.decode(_user.token!);

    id = token['preferred_username'];

/*    print("cek---------++");
    print(_user.userId);
    print(_user.id);
    print("cek---------++");*/
    try {
      await Get.find<AuthController>().session();

      final _response = await _dio.get(
          '${CatApi.baseUrl}/user_services/api/v1/users/profiles/$id',
          options: Options(headers: {
            "Authorization": "Bearer ${_user.token}"
          }));

//      print(_response.data);
      if (_response.statusCode == 200) {
        UserProfile _user = UserProfile.fromMap(_response.data['data'][0][0]);
        File _file = await ImageUtil.toFile(
            ImageUtil.toUint(_user.fotoDiri!), 'profile');
//        print(_file);

        _user = _user.copyWith(fotoFile: _file);
        return _user;
      }
    } on DioError catch (e) {
      print('Got error content: ' + e.response!.data.toString());
      print(e);
    }
  }

}
