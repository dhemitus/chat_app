import 'dart:io';
import 'package:get/get.dart';
import 'package:chatapp/data/data.dart';
import 'package:tinode/tinode.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';
import 'package:chatapp/utils/utils.dart';

class TinodeController extends GetxController {
  TinodeService _tinode = TinodeService.instance;
  late Topic _topic;
  late TopicMe _me;
  RxList<types.Message> listChat = <types.Message>[].obs;
  Rx<types.User> user = types.User(id:'').obs;
  RxList<ChatSubscribe> contacts = <ChatSubscribe>[].obs;
  RxString topic = ''.obs;
  RxString name = ''.obs;
  late DateTime _touched;
  RxBool newMessage = false.obs;
  Rx<ChatSubscribe> room = ChatSubscribe().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initialize();
  print('init tinode');
  }

  @override
  void onClose() {
    _tinode.unSubscribe();
    super.onClose();
  }

  initialize() async {
    await _tinode.initialize();
    _tinode.tinode.onMessage.listen((value) {
      print('c onmessage ====================');
      if(value.data != null) print('data ' + value.data.toString());
      if(value.ctrl != null) print('ctrl ' + value.ctrl.toString());
      if(value.info != null) print('info ' + value.info.toString());
      if(value.pres != null) print('press ' + value.pres.toString());
      if(value.meta != null) print('meta ' + value.meta.toString());
      newMessage.value = value.pres != null;
      print('c onmessage ====================');

    });
  }

  Future<void> login() async {
    if(_tinode.tinode == null || _tinode.tinode.isConnected == false) {
      await initialize();
    }

    await _tinode.login();
    print(_tinode.tinode);
    print(_tinode.tinode.isAuthenticated);

    user.value = types.User(id:_tinode.userId);
    await getMeTopic();
  }

  void _setSubscriber(List<TopicSubscription> v) {
    List<ChatSubscribe> _list = [];
    v.map((e) async {
      File _file = await ImageUtil.toFile(
          ImageUtil.toUint(e.public['photo']['data']), e.topic!);
      _list.add(ChatSubscribe(
          subscribe: e,
          name: e.public['fn'],
          topic: e.topic,
          photo: e.public['photo']['data'],
          unread: e.unread,
          seen: e.seen!.when,
          avatar: _file
      ));
    }).toList();
    contacts.value = _list;
  }

  void _meSubsUpdate(List<TopicSubscription> value) {
    _setSubscriber(value);
  }

  void _meMeta(MetaMessage value) {
    _setSubscriber(value.sub!);

    print('on meta cek cek');
  }

  /*void _onContacts() {
    contacts.value = _me.contacts;
    contacts.value.map((e) => print('name ${e.public['fn']} recv ${e.recv} read ${e.read} unread ${e.unread}')).toList();

  }*/

  Future<void> getMeTopic() async {
    _me = await _tinode.getMeTopic();
    _me.onSubsUpdated.listen(_meSubsUpdate);
    _me.onMeta.listen(_meMeta);

  }

  Future<void> setTopic(TopicSubscription tp) async {
    topic.value = tp.topic!;
    name.value = tp.public['fn'];
    print('seeeeen');
    print(tp.seen!.when);
    _touched = tp.touched!;
    File _file = await ImageUtil.toFile(
        ImageUtil.toUint(tp.public['photo']['data']), tp.topic!);
    room.value = ChatSubscribe(
        subscribe: tp,
        name: tp.public['fn'],
        topic: tp.topic,
        photo: tp.public['photo']['data'],
        unread: tp.unread,
        avatar: _file,
        seen: tp.seen!.when
    );
  }

  void setChat(String chat) {
    topic.value = chat;
  }

  void _onData(DataMessage? _data) {
    if(_data != null) {
      print('total');
//      _topic.messages.map((e) => print(e.content)).toList();
      print('total');
      print('${_data.topic} ${_data.content}');
      _chatDataParse();
    }
  }

  Future<void> getTopic(String topic) async {
    _topic = await _tinode.getTopic(topic, _touched);
    name.value = _topic.public['fn'];
    print('controller hasil message =====================');
    _chatDataParse();
    print('controller hasil message =====================');
    _topic.onData.listen(_onData);

    _topic.onMeta.listen((value) {
      print('on metaaaaaaaaaaa===========');
      print(value.sub);
      print('on metaaaaaaaaaaa===========');
    });

    _topic.onPres.listen((value) {
      print(value.topic);
    });

    _topic.onInfo.listen((_info){
      //if(_info != null) {
//        print('oniinfo ===');
      print(_topic.recv);
//        print(_info.topic);
      //}
    });
  }

  Future<void> sendMessage(types.TextMessage message) async {
    await _tinode.sendMessage(message.text);
  }

  void _chatDataParse() {
    listChat.value = [];
    if(_topic != null && _topic.messages.isNotEmpty) {
      List<DataMessage> _list = _topic.messages.reversed.toList();
      _list.map((DataMessage d){
//        print('content ${d.content} from ${d.from}');
        types.TextMessage _chat = types.TextMessage(
            text: d.content,
            author: types.User(id: d.from!),
            id: const Uuid().v4(),
            createdAt: d.ts!.millisecondsSinceEpoch
        );
        listChat.value.add(_chat);
      }).toList();
    }
  }
}
