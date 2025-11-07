import 'package:cloud_firestore/cloud_firestore.dart';

class KycModel {
  const KycModel({
    required this.uid,
    required this.panNumberMasked,
    required this.idFrontUrl,
    required this.idBackUrl,
    required this.selfieUrl,
    required this.status,
    required this.reason,
    required this.reviewedBy,
    required this.updatedAt,
  });

  final String uid;
  final String? panNumberMasked;
  final String? idFrontUrl;
  final String? idBackUrl;
  final String? selfieUrl;
  final String status;
  final String? reason;
  final String? reviewedBy;
  final DateTime updatedAt;

  factory KycModel.fromJson(Map<String, dynamic> json, String uid) {
    return KycModel(
      uid: uid,
      panNumberMasked: json['panNumberMasked'] as String?,
      idFrontUrl: json['idFrontUrl'] as String?,
      idBackUrl: json['idBackUrl'] as String?,
      selfieUrl: json['selfieUrl'] as String?,
      status: json['status'] as String? ?? 'pending',
      reason: json['reason'] as String?,
      reviewedBy: json['reviewedBy'] as String?,
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'panNumberMasked': panNumberMasked,
      'idFrontUrl': idFrontUrl,
      'idBackUrl': idBackUrl,
      'selfieUrl': selfieUrl,
      'status': status,
      'reason': reason,
      'reviewedBy': reviewedBy,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
