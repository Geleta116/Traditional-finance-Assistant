import 'package:traditional_financial_asistant/infrastructure/register/memberDto.dart';

class Member {
  String? username;
  String? won;
  String? paid;

  Member({this.username, this.won, this.paid});

  toMemberDto() {
    return MemberDto(
      username: username,
      won:won,
      paid: paid
    );
  }
   factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      username: json['username'],
      won: json['won'],
      paid: json['paid'],
    );
  }

  toJson() {
    return {
      "username": username,
      "won": won,
      "paid": paid,
    };
  }

}
