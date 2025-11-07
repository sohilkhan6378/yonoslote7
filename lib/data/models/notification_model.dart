import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  const NotificationModel({
    required this.id,
    required this.uid,
    required this.title,
    required this.body,
    required this.type,
    required this.read,
    required this.createdAt,
  });

  final String id;
  final String uid;
  final String title;
  final String body;
  final String type;
  final bool read;
  final DateTime createdAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json, String id) {
    return NotificationModel(
      id: id,
      uid: json['uid'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: json['type'] as String? ?? 'info',
      read: json['read'] as bool? ?? false,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'title': title,
      'body': body,
      'type': type,
      'read': read,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
