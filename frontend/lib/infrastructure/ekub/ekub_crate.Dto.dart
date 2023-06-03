class EkubCreateDto {
  String? code;
  EkubCreateDto({this.code});

  factory EkubCreateDto.fromJson(Map<String, dynamic> json) {
    return EkubCreateDto(code: json['code']);
  }
}
