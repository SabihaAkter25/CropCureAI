import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService extends ChangeNotifier {
  static const String _key = 'app_language';
  bool _isBangla = true;

  bool get isBangla => _isBangla;
  String get currentCode => _isBangla ? 'bn' : 'en';

  LanguageService() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _isBangla = prefs.getBool(_key) ?? true;
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    _isBangla = !_isBangla;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, _isBangla);
    notifyListeners();
  }

  Future<void> setBangla(bool isBn) async {
    _isBangla = isBn;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, _isBangla);
    notifyListeners();
  }

  String getText(String key) {
    if (_isBangla) {
      return _banglaStrings[key] ?? _englishStrings[key] ?? key;
    } else {
      return _englishStrings[key] ?? key;
    }
  }

  static const Map<String, String> _banglaStrings = {
    'appName': 'CropCure AI',
    'appTagline': 'নীরোগ ফসল, সমৃদ্ধ ফসল',
    'greeting': 'আসসালামু আলাইকুম, কৃষক ভাই!',
    'greetingSub': 'আপনার ধানের স্বাস্থ্য পরীক্ষা ও দ্রুত চিকিৎসা সমাধান পান।',
    'heroTitle': 'ধানের রোগ শনাক্ত করুন',
    'heroSubtitle': 'এআই প্রযুক্তি দিয়ে মাত্র কয়েক সেকেন্ডে পাতার রোগ নির্ণয় করুন',
    'btnDetect': 'ধানের রোগ শনাক্ত করুন',
    'btnHistory': 'পূর্ববর্তী রিপোর্ট দেখুন',
    'cardDetectTitle': 'রোগ শনাক্তকরণ',
    'cardDetectSub': 'ক্যামেরা দিয়ে ছবি তুলুন',
    'cardLibraryTitle': 'রোগ নির্দেশিকা',
    'cardLibrarySub': 'ধানের প্রধান ৬টি রোগ',
    'cardTreatmentTitle': 'চিকিৎসা নির্দেশিকা',
    'cardTreatmentSub': 'পরীক্ষিত ছত্রাকনাশক তালিকা',
    'cardHistoryTitle': 'সংরক্ষিত রিপোর্ট',
    'cardHistorySub': 'আগের সব স্ক্যানের তথ্য',
    'farmingTipTitle': 'আজকের কৃষি টিপস',
    'farmingTipText': 'ধান গাছে বাদামী দাগ বা খোল পচা লক্ষণ দেখা দিলে দ্রুত আক্রান্ত পাতা কেটে আলাদা করুন এবং সুষম পটাশ সার ব্যবহার নিশ্চিত করুন।',
    'navHome': 'হোম',
    'navHistory': 'ইতিহাস',
    'navDiseases': 'রোগ সমূহ',
    'navProfile': 'প্রোফাইল',
    'detectTitle': 'ধানের পাতা স্ক্যান করুন',
    'cameraBtn': 'ক্যামেরা দিয়ে ছবি তুলুন',
    'galleryBtn': 'গ্যালারি থেকে ছবি নিন',
    'detectInstruction': 'ধান পাতার আক্রান্ত অংশের স্পষ্ট ছবি তুলুন। ছবি তোলার সময় পর্যাপ্ত আলো নিশ্চিত করুন।',
    'startAnalysis': 'এআই বিশ্লেষণ শুরু করুন',
    'analyzingText': 'এআই মডেল দিয়ে পাতা বিশ্লেষণ করা হচ্ছে...',
    'resultTitle': 'রোগ নির্ণয় রিপোর্ট',
    'confidenceLabel': 'এআই নির্ভুলতা (Confidence):',
    'symptomsLabel': 'আক্রান্ত লক্ষণসমূহ:',
    'treatmentLabel': 'সুপারিশকৃত চিকিৎসা ও ওষুধ:',
    'preventionLabel': 'প্রতিরোধমূলক ব্যবস্থা:',
    'causesLabel': 'রোগের কারণ:',
    'saveReport': 'রিপোর্ট সংরক্ষণ করুন',
    'reportSavedMsg': 'রিপোর্টটি সফলভাবে সংরক্ষণে যোগ করা হয়েছে!',
    'scanAgain': 'নতুন পাতা স্ক্যান করুন',
    'libraryTitle': 'ধানের রোগ এনসাইক্লোপিডিয়া',
    'searchHint': 'রোগের নাম লিখুন...',
    'historyTitle': 'সংরক্ষিত স্ক্যান ইতিহাস',
    'noHistory': 'এখনও কোনো স্ক্যান ইতিহাস নেই।',
    'clearHistory': 'সব ইতিহাস মুছুন',
    'profileTitle': 'কৃষক প্রোফাইল ও সেটিংস',
    'farmerName': 'মোঃ আব্দুর রহিম',
    'farmerLocation': 'দিনাজপুর, বাংলাদেশ',
    'farmerCrop': 'আমন ও বোরো ধান চাষী',
    'languageLabel': 'অ্যাপের ভাষা (Language)',
    'banglaOption': 'বাংলা',
    'englishOption': 'English',
    'serverConfigTitle': 'এআই ব্যাকএন্ড সার্ভার কনফিগারেশন',
    'serverUrlLabel': 'FastAPI Endpoint URL',
    'testConnBtn': 'সার্ভার সংযোগ পরীক্ষা করুন',
    'connSuccess': 'FastAPI ব্যাকএন্ড সার্ভার অনলাইনে আছে!',
    'connFail': 'ব্যাকএন্ড কানেক্ট হতে পারেনি। লোকাল মোড সক্রিয় থাকবে।',
    'helplineTitle': 'কৃষি সেবা হটলাইন',
    'helplineSub': '১৬১২৩ (কৃষি কল সেন্টার - বিনামূল্যে কল করুন)',
    'callNow': 'কল করুন',
    'appInfoTitle': 'অ্যাপ পরিচিতি',
    'appVersion': 'CropCure AI Version 1.0.0',
    'appDesc': 'বাংলাদেশের ধান চাষীদের জন্য নির্মিত এআই-ভিত্তিক স্মার্ট রোগ শনাক্তকরণ অ্যাপ।',
  };

  static const Map<String, String> _englishStrings = {
    'appName': 'CropCure AI',
    'appTagline': 'Healthy Crops, Better Harvests.',
    'greeting': 'Assalamu Alaikum, Farmer!',
    'greetingSub': 'Check your paddy crop health & get fast treatment solutions.',
    'heroTitle': 'Paddy Disease Detection',
    'heroSubtitle': 'Identify leaf diseases in seconds using AI technology',
    'btnDetect': 'Detect Paddy Disease',
    'btnHistory': 'View Previous Reports',
    'cardDetectTitle': 'Disease Detection',
    'cardDetectSub': 'Take photo with camera',
    'cardLibraryTitle': 'Disease Library',
    'cardLibrarySub': '6 Key Paddy Diseases',
    'cardTreatmentTitle': 'Treatment Guide',
    'cardTreatmentSub': 'Verified fungicides list',
    'cardHistoryTitle': 'Saved Reports',
    'cardHistorySub': 'History of past scans',
    'farmingTipTitle': 'Today\'s Farming Tip',
    'farmingTipText': 'If brown spots or sheath blight appear, prune infected leaves immediately and ensure balanced Potash fertilizer application.',
    'navHome': 'Home',
    'navHistory': 'History',
    'navDiseases': 'Diseases',
    'navProfile': 'Profile',
    'detectTitle': 'Scan Paddy Leaf',
    'cameraBtn': 'Take Photo with Camera',
    'galleryBtn': 'Choose from Gallery',
    'detectInstruction': 'Capture a clear, well-lit photo of the affected paddy leaf section.',
    'startAnalysis': 'Start AI Analysis',
    'analyzingText': 'Analyzing leaf with AI Model...',
    'resultTitle': 'Diagnosis Report',
    'confidenceLabel': 'AI Confidence Score:',
    'symptomsLabel': 'Symptoms Observed:',
    'treatmentLabel': 'Recommended Treatment & Remedies:',
    'preventionLabel': 'Prevention Measures:',
    'causesLabel': 'Root Causes:',
    'saveReport': 'Save Report',
    'reportSavedMsg': 'Report saved successfully to history!',
    'scanAgain': 'Scan Another Leaf',
    'libraryTitle': 'Paddy Disease Library',
    'searchHint': 'Search disease name...',
    'historyTitle': 'Saved Scan History',
    'noHistory': 'No scan history recorded yet.',
    'clearHistory': 'Clear All History',
    'profileTitle': 'Farmer Profile & Settings',
    'farmerName': 'Md. Abdur Rahim',
    'farmerLocation': 'Dinajpur, Bangladesh',
    'farmerCrop': 'Aman & Boro Rice Farmer',
    'languageLabel': 'App Language',
    'banglaOption': 'বাংলা',
    'englishOption': 'English',
    'serverConfigTitle': 'AI Backend Server Config',
    'serverUrlLabel': 'FastAPI Endpoint URL',
    'testConnBtn': 'Test Connection',
    'connSuccess': 'FastAPI backend server is online!',
    'connFail': 'Backend unreachable. Local offline mode enabled.',
    'helplineTitle': 'Agriculture Helpline',
    'helplineSub': '16123 (Krishi Call Center - Toll Free)',
    'callNow': 'Call Now',
    'appInfoTitle': 'About CropCure AI',
    'appVersion': 'CropCure AI Version 1.0.0',
    'appDesc': 'AI-powered smart paddy disease detection app built for Bangladeshi farmers.',
  };
}
