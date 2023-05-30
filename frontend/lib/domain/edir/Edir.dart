import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:traditional_financial_asistant/domain/edir/models/Edir.dart';
import 'package:traditional_financial_asistant/infrastructure/edir/edir.Dto.dart';
import 'package:traditional_financial_asistant/domain/edir/ValidNumber.dart';

import 'EdirFailure.dart';
import 'EdirTitle.dart';




class Edir {



  final ValidNumber countdown;
  final EdirTitle name;
  final ValidNumber amount;
  final ValidNumber duration;



  Edir(
      {required this.countdown,
      required this.name,
      required this.amount,
      required this.duration});

  factory Edir.create(
      {required ValidNumber countdown,
      required EdirTitle name,
      required ValidNumber amount,
      required ValidNumber duration}) {

    return Edir(
        countdown: countdown,
        name: name,
        amount: amount,
        duration: duration);
  }
  

  Either<EdirFailure, Unit> validateEdir() {
    if (countdown.value.isLeft()) {
      return left(const InvalidNumber());
    } else if (duration.value.isLeft()) {
      return left(const InvalidNumber());
    } else if (amount.value.isLeft()) {
      return left(const InvalidNumber());
    }  else if (name.value.isLeft()) {
      return left(const InvalidTitle());
    } else {
      return right(unit);
    }
  }

  


  EdirDto toDto() {
    return EdirDto(
      countdown: int.parse(countdown.value.getOrElse(() => "0")),
      name: name.value.getOrElse(() => ""),
      amount: int.parse(amount.value.getOrElse(() => "0")),
      duration: int.parse(duration.value.getOrElse(() => "0")),
    );
  }



  Map<String, dynamic> toJson() => {
        'description': countdown.value.getOrElse(() => ""),
        'name': name.value.getOrElse(() => ""),
        'amount': amount.value.getOrElse(() => ""),
        'duration': duration.value.getOrElse(() => ""),
      };





  factory Edir.fromJson(Map<String, dynamic> json) {
    return Edir(
        countdown: ValidNumber(json['description']),
        name: EdirTitle(json['name']),
        amount: ValidNumber(json['amount']),
        duration: ValidNumber(json['duration']));
        }
        
  



  toEdirModel() {
    return EdirModel(
      countdown: countdown.value.getOrElse(() => ""),
      name: name.value.getOrElse(() => ""),
      amount: amount.value.getOrElse(() => "0"),
      duration: duration.value.getOrElse(() => "0"),
    );
  }
  
}



