import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:traditional_financial_asistant/infrastructure/ekub/ekub.Dto.dart';

import 'EkubFailure.dart';
import 'EkubTitle.dart';
import 'validNumber.dart';
import 'Description.dart';
import 'package:traditional_financial_asistant/domain/ekub/models/models.dart';

class Ekub {
  final Description description;
  final EkubTitle name;
  final ValidNumber amount;
  final ValidNumber minMembers;
  final ValidNumber countdown;
  final ValidNumber duration;
  bool? creator;
  bool? canPay;

  Ekub(
      {required this.description,
      required this.name,
      required this.amount,
      required this.countdown,
      required this.minMembers,
      required this.duration,
      this.creator,
      this.canPay});

  factory Ekub.create(
      {required Description description,
      required EkubTitle name,
      required ValidNumber amount,
      required ValidNumber minMembers,
      required ValidNumber countdown,
      required ValidNumber duration,
      bool? creator,
      bool? canPay}) {
    return Ekub(
        description: description,
        name: name,
        amount: amount,
        minMembers: minMembers,
        countdown: countdown,
        duration: duration,
        creator: creator,
        canPay: canPay);
  }

  Either<EkubFailure, Unit> validateEkub() {
    if (description.value.isLeft()) {
      return left(const InvalidDescription());
    } else if (duration.value.isLeft()) {
      return left(const InvalidNumber());
    } else if (amount.value.isLeft()) {
      return left(const InvalidNumber());
    } else if (countdown.value.isLeft()) {
      return left(const InvalidNumber());
    } else if (minMembers.value.isLeft()) {
      return left(const InvalidNumber());
    } else if (name.value.isLeft()) {
      return left(const InvalidTitle());
    } else {
      return right(unit);
    }
  }

  EkubDto toDto() {
    return EkubDto(
        description: description.value.getOrElse(() => ""),
        name: name.value.getOrElse(() => ""),
        amount: int.parse(amount.value.getOrElse(() => '0')),
        minMembers: int.parse(minMembers.value.getOrElse(() => '0')),
        countdown: int.parse(countdown.value.getOrElse(() => '0')),
        duration: int.parse(duration.value.getOrElse(() => '0')),
        creator: creator,
        canPay: canPay);
  }

  Map<String, dynamic> toJson() => {
        'description': description.value.getOrElse(() => ""),
        'name': name.value.getOrElse(() => ""),
        'amount': amount.value.getOrElse(() => ""),
        'minMembers': minMembers.value.getOrElse(() => ""),
        'countdown': countdown.value.getOrElse(() => ""),
        'duration': duration.value.getOrElse(() => ""),
        'creator': creator,
        'canPay': canPay
      };

  factory Ekub.fromJson(Map<String, dynamic> json) {
    print(json);

    try {
      return Ekub(
          description: Description(json['description']),
          name: EkubTitle(json['name']),
          amount: ValidNumber(json['amount']),
          minMembers: ValidNumber(json['minMembers']),
          duration: ValidNumber(json['duration']),
          countdown: ValidNumber(json['countdown']),
          creator: json['creator'],
          canPay: json['canPay']);
    } catch (e) {
      print(e);
      throw Exception('error');
    }
  }

  toEqubModel() {
    return EkubModel(
        description: description.value.getOrElse(() => ""),
        name: name.value.getOrElse(() => ""),
        amount: amount.value.getOrElse(() => ""),
        minMembers: minMembers.value.getOrElse(() => ""),
        countdown: countdown.value.getOrElse(() => ""),
        duration: duration.value.getOrElse(() => ""),
        creator: creator,
        canPay: canPay);
  }
}
