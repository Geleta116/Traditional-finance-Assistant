// import 'package:traditional_financial_asistant/domain/register/edirmember_model.dart';

import '../../domain/register/edirmember.dart';
import '../../domain/register/memeber_model.dart';

class EdirMemberDto {
  final String? username;
  final String? penality;
  final String? paid;

  EdirMemberDto({this.username, this.penality, this.paid});

  Map<String, dynamic> toJson() => {
        'username': username,
        'penality': penality,
        'paid': paid,
      };

  factory EdirMemberDto.fromJson(Map<String, dynamic> json) {
    return EdirMemberDto(
      username: json['username'],
      penality: json['penality'].toString(),
      paid: json['paid'].toString(),
    );
  }

  EdirMember toEdirMemeber() {
    print('to memeber');
    try {
      return EdirMember(
        username: username,
        penality: penality,
        paid: paid,
      );
    } catch (e) {
      print(e);
      throw Exception("Could not fetch Members");
    }
  }
}
