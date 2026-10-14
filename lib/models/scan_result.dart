import 'dart:convert';
import 'disease.dart';

class ScanResult {
  final String id;
  final String imagePath;
  final String diseaseId;
  final String diseaseNameEn;
  final String diseaseNameBn;
  final double confidence; // e.g. 0.94 or 94.0
  final DateTime timestamp;
  final String? rawResponse;

  ScanResult({
    required this.id,
    required this.imagePath,
    required this.diseaseId,
    required this.diseaseNameEn,
    required this.diseaseNameBn,
    required this.confidence,
    required this.timestamp,
    this.rawResponse,
  });

  Disease get disease => Disease.getById(diseaseId);

  // Confidence string in % format (e.g. "94.5%")
  String get formattedConfidence {
    final double pct = confidence > 1.0 ? confidence : confidence * 100;
    return '${pct.toStringAsFixed(1)}%';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'diseaseId': diseaseId,
      'diseaseNameEn': diseaseNameEn,
      'diseaseNameBn': diseaseNameBn,
      'confidence': confidence,
      'timestamp': timestamp.toIso8601String(),
      'rawResponse': rawResponse,
    };
  }

  factory ScanResult.fromJson(Map<String, dynamic> json) {
    return ScanResult(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      imagePath: json['imagePath'] ?? '',
      diseaseId: json['diseaseId'] ?? 'rice_blast',
      diseaseNameEn: json['diseaseNameEn'] ?? 'Rice Blast',
      diseaseNameBn: json['diseaseNameBn'] ?? 'ধানের ব্লাস্ট রোগ',
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.85,
      timestamp: DateTime.tryParse(json['timestamp'] ?? '') ?? DateTime.now(),
      rawResponse: json['rawResponse'],
    );
  }

  String encode() => jsonEncode(toJson());

  factory ScanResult.decode(String str) => ScanResult.fromJson(jsonDecode(str));
}
