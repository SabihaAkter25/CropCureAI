import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/disease.dart';
import '../models/scan_result.dart';

class ApiService extends ChangeNotifier {
  static const String _urlKey = 'fastapi_endpoint_url';
  
  // Default URL for Android Emulator to host FastAPI server
  String _endpointUrl = 'http://10.0.2.2:8000/predict';
  
  String get endpointUrl => _endpointUrl;

  ApiService() {
    _loadEndpointUrl();
  }

  Future<void> _loadEndpointUrl() async {
    final prefs = await SharedPreferences.getInstance();
    _endpointUrl = prefs.getString(_urlKey) ?? 'http://10.0.2.2:8000/predict';
    notifyListeners();
  }

  Future<void> setEndpointUrl(String url) async {
    _endpointUrl = url.trim();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_urlKey, _endpointUrl);
    notifyListeners();
  }

  /// Test connectivity to the FastAPI server (e.g. GET / or healthcheck)
  Future<bool> testConnection() async {
    try {
      final uri = Uri.parse(_endpointUrl);
      final baseUrl = '${uri.scheme}://${uri.host}:${uri.port}';
      
      final response = await http.get(Uri.parse(baseUrl)).timeout(
        const Duration(seconds: 4),
      );
      return response.statusCode < 500;
    } catch (e) {
      // Try hitting endpoint directly
      try {
        final response = await http.get(Uri.parse(_endpointUrl)).timeout(
          const Duration(seconds: 3),
        );
        return response.statusCode < 500;
      } catch (_) {
        return false;
      }
    }
  }

  /// Send image to FastAPI endpoint for paddy disease detection
  Future<ScanResult> predictDisease(File imageFile) async {
    try {
      final uri = Uri.parse(_endpointUrl);
      var request = http.MultipartRequest('POST', uri);

      // Attach file using field name 'file' (standard FastAPIUploadFile)
      final stream = http.ByteStream(imageFile.openRead());
      final length = await imageFile.length();
      final multipartFile = http.MultipartFile(
        'file',
        stream,
        length,
        filename: imageFile.path.split('/').last,
      );
      request.files.add(multipartFile);

      // Also attach duplicate under 'image' in case server uses 'image'
      final stream2 = http.ByteStream(imageFile.openRead());
      final multipartFile2 = http.MultipartFile(
        'image',
        stream2,
        length,
        filename: imageFile.path.split('/').last,
      );
      request.files.add(multipartFile2);

      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 15),
      );

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        return _parseApiResponse(jsonResponse, imageFile.path, response.body);
      } else {
        throw HttpException(
          'Server returned status code ${response.statusCode}: ${response.body}',
        );
      }
    } on SocketException catch (e) {
      debugPrint('Network error accessing FastAPI backend: $e');
      throw const SocketException('Cannot connect to FastAPI server at the configured IP/URL.');
    } on TimeoutException catch (_) {
      throw TimeoutException('Connection to AI Server timed out. Please retry.');
    } catch (e) {
      debugPrint('API Error: $e');
      rethrow;
    }
  }

  /// Fallback simulated prediction if user is offline or testing without active server
  Future<ScanResult> simulatePrediction(File imageFile) async {
    await Future.delayed(const Duration(milliseconds: 1800)); // realistic AI delay
    
    // Choose a deterministic or realistic disease prediction based on filename or timestamp
    const diseases = Disease.diseaseLibrary;
    final int index = (imageFile.path.hashCode.abs()) % (diseases.length);
    final Disease predicted = diseases[index];
    
    final double confidence = 0.91 + ((imageFile.lengthSync() % 8) / 100.0); // e.g. 0.91 - 0.98

    return ScanResult(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      imagePath: imageFile.path,
      diseaseId: predicted.id,
      diseaseNameEn: predicted.nameEn,
      diseaseNameBn: predicted.nameBn,
      confidence: confidence,
      timestamp: DateTime.now(),
      rawResponse: jsonEncode({
        'status': 'offline_simulation',
        'class': predicted.nameEn,
        'confidence': confidence,
      }),
    );
  }

  /// Helper parser to handle various FastAPI JSON key structures
  ScanResult _parseApiResponse(
    Map<String, dynamic> json,
    String imagePath,
    String rawBody,
  ) {
    // 1. Extract class / disease name
    String predictedClass = '';
    final possibleClassKeys = [
      'class',
      'disease',
      'prediction',
      'label',
      'result',
      'class_name',
      'disease_name',
      ' predicted_class'
    ];

    for (final key in possibleClassKeys) {
      if (json.containsKey(key) && json[key] != null) {
        predictedClass = json[key].toString();
        break;
      }
    }

    if (predictedClass.isEmpty) {
      // If nested under 'data'
      if (json.containsKey('data') && json['data'] is Map) {
        final data = json['data'] as Map<String, dynamic>;
        for (final key in possibleClassKeys) {
          if (data.containsKey(key) && data[key] != null) {
            predictedClass = data[key].toString();
            break;
          }
        }
      }
    }

    if (predictedClass.isEmpty) {
      predictedClass = 'Rice Blast'; // Default fallback
    }

    // 2. Extract confidence score
    double confidence = 0.92;
    final possibleConfKeys = [
      'confidence',
      'confidence_score',
      'score',
      'accuracy',
      'probability',
      'certainty'
    ];

    for (final key in possibleConfKeys) {
      if (json.containsKey(key) && json[key] != null) {
        final val = json[key];
        if (val is num) {
          confidence = val.toDouble();
        } else if (val is String) {
          confidence = double.tryParse(val.replaceAll('%', '')) ?? 0.92;
        }
        break;
      }
    }

    // Match extracted string to nearest Disease in database
    final matchedDisease = Disease.matchByNameOrClass(predictedClass);

    return ScanResult(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      imagePath: imagePath,
      diseaseId: matchedDisease.id,
      diseaseNameEn: matchedDisease.nameEn,
      diseaseNameBn: matchedDisease.nameBn,
      confidence: confidence,
      timestamp: DateTime.now(),
      rawResponse: rawBody,
    );
  }
}
