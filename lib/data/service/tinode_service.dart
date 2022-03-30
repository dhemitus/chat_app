import 'package:tinode/tinode.dart';
import 'package:get_storage/get_storage.dart';
import 'package:chatapp/data/data.dart';

class TinodeService {
  static TinodeService get instance => TinodeService._();
  String _key = CatApi.tinodeKey;
  String _host = CatApi.tinodeHost;
  late Tinode _tinode;
  final GetStorage _record = GetStorage();
  Tinode get tinode => _tinode;
  late TopicMe _me;
  late Topic _topic;
  late String _userId;

  String get userId => _userId;

  TinodeService._();

  Future<void> initialize() async {
    try {
      print('start run tinode ============');
      _tinode =
          Tinode('cat_app', ConnectionOptions(_host, _key, secure: true), true);
      print('tinode is connected ${_tinode.isConnected.toString()}');

      CtrlMessage _connect = await _tinode.connect();
      if(_connect.code! < 300) {
        print('connected to tinode');
      }
      print('tinode is connected ${_tinode.isConnected.toString()}');
    } catch (e) {
      print('cannot connect to tinode');
      print(e.toString());
    }
  }

  Future<void> login() async {
    try {
      String _session = _record.read('session');
      UserSession _user = UserSession.fromJson(_session);
      print(_user.tinodeToken);

      CtrlMessage _result = await _tinode.loginToken(
          _user.tinodeToken!, Map<String, dynamic>());
      _userId = _tinode.userId;
      print('login result ====');
      print(_result);
      print(_userId);
    } catch (e) {
      print('login error ====');
      print(e);
      print('login error ====');
    }
  }

  Future<TopicMe> getMeTopic() async {
    _me = _tinode.getMeTopic();

    if(!_me.isSubscribed) {
      await _me.subscribe(MetaGetBuilder(_me).withLaterSub(null).withDesc(null).withCred().build(), null);

//      print(_me.contacts);
//      print('get contact');
//      onContacts();

    }

    return _me;
  }

  Future<Topic> getTopic(String topic, DateTime touched) async {
    /*if(_topic != null && _topic.isSubscribed) {
      _topic.leave(true);
    }*/
    _topic = _tinode.getTopic(topic);
    print(_tinode.userId);
    print(_topic.public);

    if(!_topic.isSubscribed) {
      await _topic.subscribe(MetaGetBuilder(_tinode.getTopic(topic)).withSub(null, null, null).withData(null,null,24).withDesc(touched).withTags().build(), null);
      await _topic.getMessagesPage(0, true);

    }

    return _topic;
  }

  Future<void> sendMessage(String message) async {
    var _msg = _topic.createMessage(message, true);
    await _topic.publishMessage(_msg);
  }

  void unSubscribe() {
    _me.resetSubscription();
    _topic.resetSubscription();
  }
}
