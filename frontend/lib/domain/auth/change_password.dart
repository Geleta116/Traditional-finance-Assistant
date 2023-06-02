class ChangePasswordModel{

  String? oldpassword;
  String? newpassword;

  ChangePasswordModel({this.oldpassword,this.newpassword});

  toJson() {
    return {
      "oldpassword": oldpassword,
      "newpassword": newpassword,
    };
  }

  fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      oldpassword: json['oldpassword'],
      newpassword: json['newpassword'],
    );
  }
}