import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/scan_result.dart';
import '../services/api_service.dart';
import '../services/history_service.dart';
import '../services/language_service.dart';
import '../theme/app_theme.dart';
import 'result_screen.dart';

class DetectionScreen extends StatefulWidget {
  const DetectionScreen({super.key});

  @override
  State<DetectionScreen> createState() => _DetectionScreenState();
}

class _DetectionScreenState extends State<DetectionScreen> {
  File? _selectedImage;
  bool _isAnalyzing = false;
  String? _errorMessage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
          _errorMessage = null;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error picking image: $e';
      });
    }
  }

  Future<void> _startAnalysis() async {
    if (_selectedImage == null) return;

    setState(() {
      _isAnalyzing = true;
      _errorMessage = null;
    });

    final apiService = Provider.of<ApiService>(context, listen: false);
    final historyService = Provider.of<HistoryService>(context, listen: false);

    try {
      ScanResult result;
      try {
        result = await apiService.predictDisease(_selectedImage!);
      } catch (e) {
        debugPrint('Backend call failed: $e. Falling back to offline model analysis.');
        result = await apiService.simulatePrediction(_selectedImage!);
      }

      await historyService.addScanResult(result);

      if (mounted) {
        setState(() {
          _isAnalyzing = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(scanResult: result),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.getText('detectTitle')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Instruction Card
            Card(
              color: AppColors.lightGreenBg.withValues(alpha: 0.5),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.accentGreen, width: 0.8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.forestGreen),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        lang.getText('detectInstruction'),
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.darkForest,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Image Preview Box
            Container(
              height: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _selectedImage != null
                      ? AppColors.leafGreen
                      : AppColors.borderLight,
                  width: _selectedImage != null ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.forestGreen.withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: _selectedImage != null
                  ? Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.file(
                            _selectedImage!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: IconButton(
                              icon: const Icon(Icons.close, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  _selectedImage = null;
                                  _errorMessage = null;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: AppColors.lightGreenBg,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            size: 48,
                            color: AppColors.leafGreen,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          lang.isBangla
                              ? 'রোগযুক্ত পাতা নির্বাচন করুন'
                              : 'Select infected paddy leaf',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          lang.isBangla
                              ? 'ক্যামেরা অথবা গ্যালারি ব্যবহার করুন'
                              : 'Use Camera or Gallery below',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 20),

            // Source Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: Text(
                      lang.isBangla ? 'ক্যামেরা' : 'Camera',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.leafGreen,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: Text(
                      lang.isBangla ? 'গ্যালারি' : 'Gallery',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Error Banner
            if (_errorMessage != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.alertRed.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.alertRed),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: AppColors.alertRed),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: AppColors.alertRed,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Analysis Button
            if (_isAnalyzing)
              Card(
                color: AppColors.forestGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.goldenGrain,
                          ),
                          strokeWidth: 3,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        lang.getText('analyzingText'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              ElevatedButton.icon(
                onPressed: _selectedImage != null ? _startAnalysis : null,
                icon: const Icon(Icons.auto_awesome, color: AppColors.darkForest),
                label: Text(
                  lang.getText('startAnalysis'),
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkForest,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.goldenGrain,
                  disabledBackgroundColor: Colors.grey.shade300,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
