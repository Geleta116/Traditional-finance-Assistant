class NotificationModel{

  String username;
  String message;

  NotificationModel({required this.username, required this.message});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      username: json['username'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'message': message,
  };
  
}