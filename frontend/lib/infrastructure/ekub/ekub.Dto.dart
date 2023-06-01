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
    var currEkub = json['equb'];
    print(currEkub);

    return EkubDto(
        description: currEkub['description'],
        name: currEkub['name'],
        amount: currEkub['amount'],
        minMembers: currEkub['minMembers'],
        duration: currEkub['duration'],
        countdown: currEkub['countdown']);
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
