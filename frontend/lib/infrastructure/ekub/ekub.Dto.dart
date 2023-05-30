// ignore_for_file: non_constant_identifier_names

import '../../domain/ekub/Ekub.dart';
import 'package:traditional_financial_asistant/domain/ekub/ekub_barel.dart';

class EkubDto {
  final String name;
  final int amount;
  final int minMembers;
  final int duration;
  final String description;
  final int countdown;

  EkubDto(
      {required this.description,
      required this.name,
      required this.amount,
      required this.minMembers,
      required this.duration,
      required this.countdown});

  factory EkubDto.fromJson(Map<String, dynamic> json) {
    return EkubDto(
        description: json['description'],
        name: json['name'],
        amount: json['amount'],
        minMembers: json['minMembers'],
        duration: json['duration'],
        countdown: json['countdown']);
  }
 
 
  Map<String, dynamic> toJson() => {
        'description': description,
        'name': name,
        'amount': amount,
        'minMembers': minMembers,
        'duration': duration,
        'countdown': countdown,
      };

  Ekub toEntity() {
    return Ekub(
        description: Description(this.description),
        name: EkubTitle(this.name),
        amount: ValidNumber(this.amount.toString()),
        minMembers: ValidNumber(this.minMembers.toString()),
        duration: ValidNumber(this.duration.toString()),
        countdown: ValidNumber(this.countdown.toString()));
  }
  }


