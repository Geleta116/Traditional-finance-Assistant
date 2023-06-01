// ignore_for_file: non_constant_identifier_names

import 'package:traditional_financial_asistant/domain/join/code.dart';
import 'package:traditional_financial_asistant/domain/join/join.dart';
import 'package:traditional_financial_asistant/domain/join/name.dart';



class JoinDto {
  final String name;
  final String code;

  JoinDto({required this.name, required this.code});

  factory JoinDto.fromJson(Map<String, dynamic> json) {
    return JoinDto(
       
        name: json['name'],
        code: json['code']
       );
  }

  Map<String, dynamic> toJson() => {'name': name, 'code': code};

  Join toEntity() {
    return Join(
        
        name: JoinName(this.name),
        code: JoinCode(this.code)
       );
  }
}
