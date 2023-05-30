// ignore_for_file: non_constant_identifier_names
import '../Description.dart';
import '../EkubTitle.dart';
import '../validNumber.dart';
import '../Ekub.dart';

class EkubModel {
 String name;
 String amount;
 String minMembers;
 String duration;
 String description;
 String countdown;

  EkubModel(
      {required this.description,
      required this.name,
      required this.amount,
      required this.minMembers,
      required this.duration,
      required this.countdown});

  factory EkubModel.fromJson(Map<String, dynamic> json) {
    return EkubModel(
        description: json['description'],
        name: json['name'],
        amount: json['amount'],
        minMembers: json['minMembers'],
        duration: json['duration'],
        countdown: json['countdown']);
  }

  toEqubEntity() {
    return Ekub(
        description: Description(description),
        name: EkubTitle(name),
        amount: ValidNumber(amount),
        minMembers: ValidNumber(minMembers),
        duration: ValidNumber(duration),
        countdown: ValidNumber(countdown));
  }
}
