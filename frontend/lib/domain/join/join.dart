
import 'package:dartz/dartz.dart';
import 'package:traditional_financial_asistant/domain/ekub/models/join.dart';
// import 'package:traditional_financial_asistant/domain/ekub/models/join.dart';
import 'package:traditional_financial_asistant/infrastructure/join/join.Dto.dart';

import 'joinFailure.dart';
import 'name.dart';
import 'code.dart';


class Join {
  final JoinCode code;
  final JoinName name;

  Join({required this.name, required this.code});

  factory Join.create({required JoinName name, required JoinCode code}) {
    return Join(name: name, code: code);
  }

  Either<JoinFailure, Unit> validateJoin() {
    if (name.value.isLeft()) {
      return left(const InvalidName());
    } else if (code.value.isLeft()) {
      return left(const InvalidCode());
    } else {
      return right(unit);
    }
  }

  JoinDto toDto() {
    return JoinDto(
      name: name.value.getOrElse(() => ""),
      code: code.value.getOrElse(() => "")
   
      
    );
  }

  Map<String, dynamic> toJson() => {
       
        'name': name.value.getOrElse(() => ""),
        'code': code.value.getOrElse(() => "")
        
      };

  factory Join.fromJson(Map<String, dynamic> json) {
    return Join(
      
        name: JoinName(json['name']),
        code: JoinCode(json['code']),
        );
  }

  toJoinModel() {
    return JoinModel(
      name: name.value.getOrElse(() => ""),
      code: code.value.getOrElse(() => "")
     
    );
  }
}
