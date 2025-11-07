import 'package:cloud_firestore/cloud_firestore.dart';

/// Representation of a user profile stored in Firestore.
class UserModel {
  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.phone,
    required this.photoUrl,
    required this.kycStatus,
    required this.createdAt,
    required this.banned,
    required this.roles,
    required this.region,
  });

  final String uid;
  final String? displayName;
  final String? email;
  final String? phone;
  final String? photoUrl;
  final String kycStatus;
  final DateTime createdAt;
  final bool banned;
  final List<String> roles;
  final String? region;

  factory UserModel.fromJson(Map<String, dynamic> json, String documentId) {
    return UserModel(
      uid: documentId,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      photoUrl: json['photoUrl'] as String?,
      kycStatus: json['kycStatus'] as String? ?? 'pending',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      banned: json['banned'] as bool? ?? false,
      roles: List<String>.from(json['roles'] as List<dynamic>? ?? []),
      region: json['region'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'kycStatus': kycStatus,
      'createdAt': Timestamp.fromDate(createdAt),
      'banned': banned,
      'roles': roles,
      'region': region,
    };
  }

  UserModel copyWith({
    String? displayName,
    String? email,
    String? phone,
    String? photoUrl,
    String? kycStatus,
    bool? banned,
    List<String>? roles,
    String? region,
  }) {
    return UserModel(
      uid: uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      kycStatus: kycStatus ?? this.kycStatus,
      createdAt: createdAt,
      banned: banned ?? this.banned,
      roles: roles ?? this.roles,
      region: region ?? this.region,
    );
  }
}
