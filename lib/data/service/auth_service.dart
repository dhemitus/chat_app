import 'dart:async';
import 'package:chatapp/data/data.dart';
import 'package:chatapp/controller/controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  static AuthService get instance => AuthService._();
  Dio _dio = Dio();
  final GetStorage _record = GetStorage();

  AuthService._();

  Future<OnLogin>

  signIn(String username, String password) async {
    try {
      String _token = _record.read('fcm_token');
      print(_token);
      final _response = await _dio.post(
          '${CatApi.baseUrl}/user_services/api/v1/users/authentication/login',
          options: Options(contentType: Headers.jsonContentType),
          data: {"user_id": username, "password": password, "android_token": _token});
      if (_response.statusCode == 200) {
        print('halo==============================');
        print('tmp pass');
        print(_response.data['data']);
        print('login resulit +++++++');
        print(_response.data['data']['is_tmp_password']);
        print('pass tmp');

        //print(_record.read('session'));
        if(_response.data['data']['is_tmp_password'] == true) {
          Get.find<UserController>().userId.value = username;
          return OnLogin.first;
        } else {

          UserSession _session = UserSession.fromMap(_response.data['data']);
          //print('token');
          //print(_session.token);
          //print('data');
          //print(JwtDecoder.decode(_session.token!));
          _setRoles(_session);
          //sementara role gak kelihatan
          _record.write('session', _session.toJson());
          print(_session);
          print(_session.tinodeUserId);
          return OnLogin.notFirst;

        }
      }
      return OnLogin.failed;
    } on DioError catch (e) {
      print(e.response!.data['response_message']);
      //return OnLogin.failed;
      throw e;
    }
  }

  Future<bool> session() async {
    try {
      String? _session = _record.read('session');
      print('AuthService.session() start');
      if (_session == null) return false;

      UserSession _user = UserSession.fromJson(_session);

      print(_user.refreshToken);
      print(JwtDecoder.decode(_user.refreshToken!));

      print("start refresh token");

      //print('print +++');
      final _response = await _dio.post(
          '${CatApi.baseUrl}/user_services/api/v1/users/authentication/session',
          options: Options(contentType: Headers.jsonContentType),
          data: {"refresh_token": _user.refreshToken});
      //print('start print +++');
      print(_response.data['data']);
      //print(_response.data['data']['refresh_token']);
      //print('end print +++');
      if (_response.statusCode == 200) {
        //_user = UserSession.fromMap(_response.data['data']);
        _user = _user.copyWith(
            token: _response.data['data']['token'],
            refreshToken: _response.data['data']['refresh_token']
        );
        print('AuthService.session() tinode id ${_user.tinodeUserId}');
        _setRoles(_user);
        print('Before write to session');
        _record.write('session', _user.toJson());
        print('After write to session');
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      String? _session = _record.read('session');
      print('record token');
      if (_session == null) return false;

      UserSession _user = UserSession.fromJson(_session);

      print(_user.refreshToken);
      print(JwtDecoder.decode(_user.refreshToken!));

      //print('print +++');
      final _response = await _dio.post(
          '${CatApi.baseUrl}/user_services/api/v1/users/authentication/logout',
          options: Options(contentType: Headers.jsonContentType),
          data: {"refresh_token": _user.refreshToken, "user_id": _user.userId});
      if (_response.statusCode == 200) {
        _record.remove('session');
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic> getRoles(String param) {
    Map<String, dynamic> _roles = _record.read('roles');

    return _roles.containsKey(param) ? _roles[param] : {};
  }

  void _setRoles(UserSession _session) {

    var _roles = _session.roles;
    print(_roles);

    String _mark = 'nothing';
    Map<String, dynamic> _map = {};
    print('start rolin----');

    _roles!.map((_role) {
      List<String> _main = _role.split('-');
      if(!_role.contains(_mark)) {
        _mark = _main[0];
        _map[_mark] = _mapRoles(_mark, _roles);
      }
    }).toList();

    _record.write('roles', _map);
    print(_map);
    print('_setRoles');
    print(_record.read('roles'));
  }

  Map<String, dynamic> _mapRoles(String _mark, List<dynamic> _roles) {
    String _mid = 'nothing';
    Map<String, dynamic> _map = {};

    _roles.map((_role) {
      List<String> _main = _role.split('-');
      if(_role.contains('$_mark-${_main[1]}')) {
        _mid = _main[1];
        _map[_mid] = _setRole('$_mark-$_mid', _roles);
      }
    }).toList();

    return _map;
  }

  List<String> _setRole(String _mark, List<dynamic> _roles) {
    List<String> _role = [];

    _roles.map((_rol) {
      if(_rol.contains(_mark)) {
        _role.add(_rol.replaceAll('$_mark-', ''));
      }
    }).toList();

    return _role;
  }
}
