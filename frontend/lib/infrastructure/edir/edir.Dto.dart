// ignore_for_file: non_constant_identifier_names

// import 'package:flutter/widgets.dart';
import 'package:traditional_financial_asistant/domain/edir/Edir.dart';
import 'package:traditional_financial_asistant/domain/edir/EdirTitle.dart';
import 'package:traditional_financial_asistant/domain/edir/ValidNumber.dart';

import '../../domain/edir/edir_barel.dart';
// import '../../domain/edir/Edir.dart';

class EdirDto {
  final String name;
  final int amount;
  final int duration;
  final int countdown;

  EdirDto({
    required this.countdown,
    required this.name,
    required this.amount,
    required this.duration,
  });

  factory EdirDto.fromJson(Map<String, dynamic> json) {
    json = json["edir"];
    return EdirDto(
      countdown: json['countdown'],
      name: json['name'],
      amount: json['amount'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() => {
        'countdown': countdown,
        'name': name,
        'amount': amount,
        'duration': duration,
      };

  Edir toEntity() {
    return Edir(
      countdown: ValidNumber(this.countdown.toString()),
      name: EdirTitle(this.name),
      amount: ValidNumber(this.amount.toString()),
      duration: ValidNumber(this.duration.toString()),
    );
  }
}
