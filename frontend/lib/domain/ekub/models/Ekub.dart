// ignore_for_file: non_constant_identifier_names
import 'package:equatable/equatable.dart';

import '../Description.dart';
import '../EkubTitle.dart';
import '../validNumber.dart';
import '../Ekub.dart';


class EkubModel extends Equatable{
  String name;
  String amount;
  String minMembers;
  String duration;
  String description;
  String countdown;
  bool? creator = false;
  bool? canPay = false;


  EkubModel(
      {required this.description,
      required this.name,
      required this.amount,
      required this.minMembers,
      required this.duration,
      required this.countdown,
      this.creator,
      this.canPay});

  factory EkubModel.fromJson(Map<String, dynamic> json) {
    return EkubModel(
        description: json['description'],
        name: json['name'],
        amount: json['amount'],
        minMembers: json['minMembers'],
        duration: json['duration'],
        countdown: json['countdown'],
        creator:json['creator'],
        canPay: json['canPay']);
    
  }

  toEqubEntity() {
    return Ekub(
        description: Description(description),
        name: EkubTitle(name),
        amount: ValidNumber(amount),
        minMembers: ValidNumber(minMembers),
        duration: ValidNumber(duration),
        countdown: ValidNumber(countdown),
        creator: creator,
        canPay: canPay);
  }
  @override
  List<Object> get props => [name, amount, duration, countdown, minMembers, description];
}
