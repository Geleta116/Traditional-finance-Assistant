// ignore_for_file: non_constant_identifier_names

import 'package:traditional_financial_asistant/domain/edir/Edir.dart';
import 'package:traditional_financial_asistant/domain/edir/EdirTitle.dart';
import 'package:traditional_financial_asistant/domain/edir/ValidNumber.dart';

class EdirModel {
  final String name;
  final String amount;
  final String duration;
  final String countdown;
  bool? creator;
  String? code = "";
 

  EdirModel(
      {required this.countdown,
      required this.name,
      required this.amount,
      required this.duration,
      this.creator,
      this.code,
      });

  factory EdirModel.fromJson(Map<String, dynamic> json) {
    return EdirModel(
        countdown: json['countdown'],
        name: json['name'],
        amount: json['amount'],
        duration: json['duration'],
        creator: json['creator'],
        code: json['code']
     );
  }
 toEdirEntity() {
    return Edir(
        
        name: EdirTitle(name),
        amount: ValidNumber(amount),
        duration: ValidNumber(duration),
        countdown: ValidNumber(countdown),
        creator: creator,
        code: code);
        
  }
  


}
