class CreateEdirDto {
  String? code;

  CreateEdirDto({this.code});
   factory CreateEdirDto.fromJson(Map<String, dynamic> json) {
    return CreateEdirDto(code: json['code']);
  }
}
