// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Ekub_models/Ekub.dart';

class EkubDataProvider {
  static const String _baseUrl = "tofik api";

  Future<Ekub> create(Ekub ekub) async {
    final http.Response response = await http.post(Uri.parse(_baseUrl),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "name": ekub.name,
          "amount": ekub.amount,
          "num_people": ekub.num_people,
          "schedule" : ekub.schedule
        }));

    if (response.statusCode == 201) {
      return Ekub.fromJson(jsonDecode(response.body));
    }
    {
      throw Exception("Failed to create Ekub");
    }
  }

  // Future<Ekub> fetchByCode(String code) async {
  //   final response = await http.get(Uri.parse("$_baseUrl/$code"));

  //   if (response.statusCode == 200) {
  //     return Ekub.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception("Fetching Ekub by code failed");
  //   }
  // }

  Future<List<Ekub>> fetchAll() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final Ekubs = jsonDecode(response.body) as List;
      return Ekubs.map((e) => Ekub.fromJson(e)).toList();
    } else {
      throw Exception("Could not fetch Ekubs");
    }
  }

  Future<Ekub> update(int id, Ekub ekub) async {
    final response = await http.put(Uri.parse("$_baseUrl/$id"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "name": ekub.name,
          "amount": ekub.amount,
          "num_people": ekub.num_people,
          "schedule" : ekub.schedule
        }));

    if (response.statusCode == 200) {
      
      return Ekub.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the Ekub");
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse("$_baseUrl/$id"));
    if (response.statusCode != 204) {
      throw Exception("Failed to delete the Ekub");
    }
  }
}