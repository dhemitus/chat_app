import 'dart:io';
import 'package:tinode/tinode.dart';

import 'package:equatable/equatable.dart';

class ChatSubscribe extends Equatable {
  final TopicSubscription? subscribe;
  final String? name, topic, photo;
  final int? unread;
  final File? avatar;
  final DateTime? seen;
  final List<ChatSubscribe>? list;

  ChatSubscribe({this.subscribe, this.name, this.topic, this.photo, this.unread, this.avatar, this.seen, this.list});

  ChatSubscribe copyWith({
    TopicSubscription? subscribe,
    String? name, topic, photo,
    int? unread,
    File? avatar,
    DateTime? seen,
    List<ChatSubscribe>? list
  }) => ChatSubscribe(
      subscribe: subscribe ?? this.subscribe,
      name: name ?? this.name,
      topic: topic ?? this.topic,
      photo: photo ?? this.photo,
      unread: unread ?? this.unread,
      avatar: avatar ?? this.avatar,
      seen: seen ?? this.seen,
      list: list ?? this.list
  );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    subscribe,
    name,
    topic,
    photo,
    unread,
    avatar,
    seen,
    list
  ];
}