// import 'package:traditional_finance_assistant__app/domain/auth/User.dart';
// import 'package:traditional_finance_assistant__app/domain/register/User.dart';
// import 'package:traditional_finance_assistant__app/infrastructure/auth/accessToken.Dto.dart';
// import 'package:traditional_finance_assistant__app/infrastructure/auth/user.DTO.dart';

import '../../infrastructure/auth/accessToken.Dto.dart';
import '../../infrastructure/auth/user.Dto.dart';

class AccessToken {
  String? token;
  UserDto? user;

  AccessToken({this.token});

  AccessToken.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['user'] = this.user!.toJson();
    return data;
  }

  AccessTokenDto toDto() {
    return AccessTokenDto(
      token: token,
    );
  }
}
