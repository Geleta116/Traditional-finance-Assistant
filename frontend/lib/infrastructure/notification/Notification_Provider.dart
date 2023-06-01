// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/notification/Notification.dart';
import '../../domain/notification/notification_model.dart';

class NotificationProvider {
  static const String _baseUrl = "http://localhost:3000/equb";

  Future<List<NotificationModel>> getNotification() async {
    final response = await http.get(Uri.parse("$_baseUrl/notification"));
    if (response.statusCode == 200) {
      final notification = jsonDecode(response.body) as List;
      List<NotificationModel> notificationList = List<Notification>.from(
          notification.map((e) => NotificationModel.fromJson(e)));
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
