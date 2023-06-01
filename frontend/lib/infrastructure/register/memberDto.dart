import '../../domain/register/memeber_model.dart';

class MemberDto {
  final String? username;
  final String? won;
  final String? paid;

  MemberDto({this.username, this.won, this.paid});

  Map<String, dynamic> toJson() => {
        'username': username,
        'won': won,
        'paid': paid,
      };

  factory MemberDto.fromJson(Map<String, dynamic> json) {
    return MemberDto(
      username: json['username'],
      won: json['won'].toString(),
      paid: json['paid'].toString(),
    );
  }

  Member toMemeber() {
    print('to memeber');
    try {
      return Member(
        username: username,
        won: won,
        paid: paid,
      );
    } catch (e) {
      print(e);
      throw Exception("Could not fetch Members");
    }
  }
}
