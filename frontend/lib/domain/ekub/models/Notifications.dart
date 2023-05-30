class Notifications {
  final String message;
  final String secret;

  Notifications({required this.message, required this.secret});

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(message: json['message'], secret: json['secret']);
  }
}
