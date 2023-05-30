// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/notification/Notification.dart';

class NotificationProvider {
  static const String _baseUrl = "http://localhost:3000/equb";

  Future<List<Notification>> getNotification() async {
    final response = await http.get(Uri.parse("$_baseUrl/notification"));
    if (response.statusCode == 200) {
      final notification = jsonDecode(response.body) as List;
      List<Notification> notificationList = List<Notification>.from(
          notification.map((e) => Notification.fromJson(e)));
      return notificationList;
    } else {
      throw Exception("Could not fetch Winner");
    }
  }

  Future<void> deleteNotification() async {
    final response =
        await http.delete(Uri.parse("$_baseUrl/deleteNotification"));
    if (response.statusCode == 202) {
    } else {
      throw Exception("Could not fetch Winner");
    }
  }
}
