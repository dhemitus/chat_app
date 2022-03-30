import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:equatable/equatable.dart';

class UserSession extends Equatable {
  final String? id, userId, brid, areaId, token, refreshToken, tinodeToken, tinodeUserId, jobName, branchName;
  final List<dynamic>? roles;
  final int? refreshExpiresIn, expiresIn, notBeforePolicy;

  UserSession({this.id, this.userId, this.brid, this.areaId, this.token, this.refreshToken, this.tinodeToken, this.tinodeUserId, this.jobName, this.branchName, this.roles, this.refreshExpiresIn, this.expiresIn, this.notBeforePolicy});

  UserSession copyWith({
    String? id,
    String? userId,
    String? brid,
    String? areaId,
    String? token,
    String? refreshToken,
    String? tinodeToken,
    String? tinodeUserId,
    String? jobName,
    String? branchName,
    List<dynamic>? roles,
    int? refreshExpiresIn,
    int? expiresIn,
    int? notBeforePolicy
  }) => UserSession(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      brid: brid ?? this.brid,
      areaId: areaId ?? this.areaId,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      tinodeToken: tinodeToken ?? this.tinodeToken,
      tinodeUserId: tinodeUserId ?? this.tinodeUserId,
      jobName: jobName ?? this.jobName,
      branchName: branchName ?? this.branchName,
      roles: roles ?? this.roles,
      refreshExpiresIn: refreshExpiresIn ?? this.refreshExpiresIn,
      expiresIn: expiresIn ?? this.expiresIn,
      notBeforePolicy: notBeforePolicy ?? this.notBeforePolicy
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'user_id': userId,
    'brid': brid,
    'area_id': areaId,
    'token': token,
    'refresh_token': refreshToken,
    'tinode_token': tinodeToken,
    'tinode_user_id': tinodeUserId,
    'job_name': jobName,
    'branch_name': branchName,
    'roles': roles,
    'refresh_expires_in': refreshExpiresIn,
    'expires_in': expiresIn,
    'not_before_policy': notBeforePolicy
  };

  factory UserSession.fromMap(Map<String, dynamic> map) => UserSession(
      id: map['id'] ?? '',
      userId: map['user_id'] ?? '',
      brid: map['brid'] ?? '',
      areaId: map['area_id'] ?? '',
      token: map['token'] ?? '',
      refreshToken: map['refresh_token'] ?? '',
      tinodeToken: map['tinode_token'] ?? '',
      tinodeUserId: map['tinode_user_id'] ?? '',
      jobName: map['job_name'] ?? '',
      branchName: map['branch_name'] ?? '',
      roles: map['roles'] ?? null,
      refreshExpiresIn: map['refresh_expires_in'] ?? 0,
      expiresIn: map['expires_in'] ?? 0,
      notBeforePolicy: map['not_before_policy'] ?? 0
  );

  factory UserSession.fromJson(String json) {
    Map<String, dynamic> _map = jsonDecode(json);
    return UserSession.fromMap(_map);
  }

  factory UserSession.fromStorage() {
    GetStorage record = GetStorage();
    String session = record.read('session');
    return UserSession.fromJson(session);
  }

  String toJson() => jsonEncode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    id,
    userId,
    brid,
    areaId,
    token,
    refreshToken,
    tinodeToken,
    tinodeUserId,
    jobName,
    branchName,
    roles,
    refreshExpiresIn,
    expiresIn,
    notBeforePolicy
  ];
}
