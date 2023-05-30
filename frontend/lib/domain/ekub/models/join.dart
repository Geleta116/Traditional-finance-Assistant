// ignore_for_file: non_constant_identifier_names

import '../../join/code.dart';
import '../../join/name.dart';
import '../../join/Join.dart';

class JoinModel {
  String name;
  String code;

  JoinModel(
      {required this.name,
      required this.code});

  factory JoinModel.fromJson(Map<String, dynamic> json) {
    return JoinModel(
        name: json['name'],
        code: json['code']
        );
  }

  toJoinEntity() {
    return Join(
        name: JoinName(name),
        code: JoinCode(code)
        );
  }
}
