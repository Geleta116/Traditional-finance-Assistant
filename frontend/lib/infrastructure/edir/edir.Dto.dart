// ignore_for_file: non_constant_identifier_names

// import 'package:flutter/widgets.dart';
import 'package:traditional_financial_asistant/domain/edir/Edir.dart';
import 'package:traditional_financial_asistant/domain/edir/EdirTitle.dart';
import 'package:traditional_financial_asistant/domain/edir/ValidNumber.dart';

// import '../domain/edir/edir_barel.dart';
// import '../../domain/edir/Edir.dart';

class EdirDto {
  final String name;
  final int amount;
  final int duration;
  final int countdown;
  final bool? creator;
  final String? code;


  EdirDto({
    required this.countdown,
    required this.name,
    required this.amount,
    required this.duration,
    this.creator,
    this.code
  });

  factory EdirDto.fromJson(Map<String, dynamic> json) {
     var jso = json["edir"];
    return EdirDto(
      countdown: jso['countdown'],
      name: jso['name'],
      amount: jso['amount'],
      duration: jso['duration'],
      creator: json['creator'],
      code: json['code']
    );
  }

  factory EdirDto.fromLocalJson(Map<String, dynamic> json) {
     
    return EdirDto(
      countdown: json['countdown'],
      name: json['name'],
      amount: json['amount'],
      duration: json['duration'],
      creator: json['creator'],
      code: json['code']
    );
  }




  factory EdirDto.fromCreateJson(Map<String, dynamic> json) {
     var jso = json;
    return EdirDto(
      countdown: jso['countdown'],
      name: jso['name'],
      amount: jso['amount'],
      duration: jso['duration'],
      creator: json['creator'],
      code: json['code']
    );
  }

  Map<String, dynamic> toJson() => {
        'countdown': countdown,
        'name': name,
        'amount': amount,
        'duration': duration,
        'creator': creator,
        'code': code
      };

  Edir toEntity() {
    return Edir(
      countdown: ValidNumber(this.countdown.toString()),
      name: EdirTitle(this.name),
      amount: ValidNumber(this.amount.toString()),
      duration: ValidNumber(this.duration.toString()),
      creator: this.creator,
      code: this.code
    );
  }
}
