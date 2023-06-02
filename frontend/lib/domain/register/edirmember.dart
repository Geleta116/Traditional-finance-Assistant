
import '../../infrastructure/register/edirmember.Dto.dart';

class EdirMember {
  String? username;
  String? penality;
  String? paid;

  EdirMember({this.username, this.penality, this.paid});

  toEdirMemberDto() {
    return EdirMemberDto(
      username: username,
      penality:penality,
      paid: paid
    );
  }
   factory EdirMember.fromJson(Map<String, dynamic> json) {
    return EdirMember(
      username: json['username'],
      penality: json['penality'],
      paid: json['paid'],
    );
  }

  toJson() {
    return {
      "username": username,
      "penality": penality,
      "paid": paid,
    };
  }

}