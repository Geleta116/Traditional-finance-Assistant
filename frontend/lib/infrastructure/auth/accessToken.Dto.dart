import 'package:traditional_financial_asistant/domain/auth/accessToken.dart';
import 'package:traditional_financial_asistant/infrastructure/register/user.DTO.dart';

class AccessTokenDto {
  String? token;
  UserDto? user;

  AccessTokenDto({this.token});

  AccessTokenDto.fromJson(Map<String, dynamic> json) {
    print(json);
    // print(json['token']);
    // print(json['user']);
    token = json['token'];
    user = UserDto.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['user'] = this.user!.toJson();

    return data;
  }

  AccessToken toEntity() {
    return AccessToken(
      token: token,
    );
  }
}
