import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/scan_result.dart';

class HistoryService extends ChangeNotifier {
  static const String _storageKey = 'cropcure_scan_history';
  List<ScanResult> _history = [];

  List<ScanResult> get history => List.unmodifiable(_history);

  HistoryService() {
    loadHistory();
  }

  Future<void> loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? jsonList = prefs.getStringList(_storageKey);
      if (jsonList != null) {
        _history = jsonList.map((item) => ScanResult.decode(item)).toList();
        _history.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      }
    } catch (e) {
      debugPrint('Error loading scan history: $e');
    }
    notifyListeners();
  }

  Future<void> addScanResult(ScanResult result) async {
    _history.insert(0, result);
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> deleteScanResult(String id) async {
    _history.removeWhere((item) => item.id == id);
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> clearAllHistory() async {
    _history.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> jsonList = _history.map((item) => item.encode()).toList();
      await prefs.setStringList(_storageKey, jsonList);
    } catch (e) {
      debugPrint('Error saving scan history: $e');
    }
  }
}
