// ignore_for_file: non_constant_identifier_names

class Ekub {
  final int? id;
  final String name;
  final String amount;
  final int num_people;
  final DateTime? schedule;

  Ekub(
      {required this.id,
      required this.name,
      required this.amount,
      required this.num_people,
      this.schedule});

  factory Ekub.fromJson(Map<String, dynamic> json) {
    return Ekub(
        id: json['id'],
        name: json['name'],
        amount: json['amount'],
        num_people: json['num_people'],
        schedule: json['schedule']);
  }
}