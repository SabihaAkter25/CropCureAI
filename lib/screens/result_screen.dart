import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/disease.dart';
import '../models/scan_result.dart';
import '../services/history_service.dart';
import '../services/language_service.dart';
import '../theme/app_theme.dart';
import 'disease_detail_screen.dart';

class ResultScreen extends StatefulWidget {
  final ScanResult scanResult;

  const ResultScreen({super.key, required this.scanResult});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context);
    final historyService = Provider.of<HistoryService>(context, listen: false);
    final bool isBn = lang.isBangla;

    final Disease disease = widget.scanResult.disease;
    final File imageFile = File(widget.scanResult.imagePath);
    final bool imageExists = imageFile.existsSync();

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.getText('resultTitle')),
        actions: [
          IconButton(
            icon: Icon(_isSaved ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () async {
              if (!_isSaved) {
                await historyService.addScanResult(widget.scanResult);
                setState(() => _isSaved = true);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(lang.getText('reportSavedMsg')),
                      backgroundColor: AppColors.forestGreen,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Leaf Preview & AI Disease Header
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  // Image
                  SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: imageExists
                        ? Image.file(
                            imageFile,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: AppColors.lightGreenBg,
                            child: const Center(
                              child: Icon(
                                Icons.eco,
                                size: 80,
                                color: AppColors.leafGreen,
                              ),
                            ),
                          ),
                  ),

                  // Header Bar
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: AppColors.forestGreen,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.goldenGrain,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                disease.severity == 'healthy'
                                    ? 'HEALTHY CROP'
                                    : 'DISEASE DETECTED',
                                style: const TextStyle(
                                  color: AppColors.darkForest,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.auto_awesome,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${lang.getText('confidenceLabel')} ${widget.scanResult.formattedConfidence}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          disease.getName(isBn),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          disease.scientificName,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.goldenGrain,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Confidence Score Visual Meter
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          lang.getText('confidenceLabel'),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          widget.scanResult.formattedConfidence,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.leafGreen,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: widget.scanResult.confidence > 1.0
                            ? widget.scanResult.confidence / 100.0
                            : widget.scanResult.confidence,
                        minHeight: 10,
                        backgroundColor: AppColors.lightGreenBg,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.leafGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Symptoms
            _buildResultCard(
              title: lang.getText('symptomsLabel'),
              icon: Icons.sick_outlined,
              iconColor: AppColors.warmAmber,
              items: disease.getSymptoms(isBn),
            ),
            const SizedBox(height: 16),

            // Verified Treatment
            _buildResultCard(
              title: lang.getText('treatmentLabel'),
              icon: Icons.medication_liquid_outlined,
              iconColor: AppColors.leafGreen,
              items: disease.getTreatment(isBn),
              isHighlight: true,
            ),
            const SizedBox(height: 16),

            // Prevention
            _buildResultCard(
              title: lang.getText('preventionLabel'),
              icon: Icons.shield_outlined,
              iconColor: AppColors.brightGreen,
              items: disease.getPrevention(isBn),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiseaseDetailScreen(disease: disease),
                        ),
                      );
                    },
                    icon: const Icon(Icons.menu_book),
                    label: Text(
                      isBn ? 'সম্পূর্ণ নির্দেশিকা' : 'Full Guide',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.forestGreen,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.refresh),
                    label: Text(
                      lang.getText('scanAgain'),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<String> items,
    bool isHighlight = false,
  }) {
    return Card(
      color: isHighlight ? AppColors.lightGreenBg.withValues(alpha: 0.3) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isHighlight
            ? const BorderSide(color: AppColors.accentGreen, width: 1.2)
            : const BorderSide(color: AppColors.borderLight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.forestGreen,
                  ),
                ),
              ],
            ),
            const Divider(height: 18),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      isHighlight ? Icons.check_circle : Icons.arrow_right,
                      size: 18,
                      color: iconColor,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                              isHighlight ? FontWeight.w600 : FontWeight.normal,
                          color: AppColors.textDark,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
