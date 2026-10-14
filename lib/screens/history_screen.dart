import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../services/history_service.dart';
import '../services/language_service.dart';
import '../theme/app_theme.dart';
import 'result_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context);
    final historyService = Provider.of<HistoryService>(context);
    final historyList = historyService.history;
    final bool isBn = lang.isBangla;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.getText('historyTitle')),
        centerTitle: true,
        actions: [
          if (historyList.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined),
              tooltip: lang.getText('clearHistory'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(lang.isBangla ? 'সব ইতিহাস মুছবেন?' : 'Clear History?'),
                    content: Text(
                      lang.isBangla
                          ? 'আপনি কি নিশ্চিত যে সমস্ত সংরক্ষিত স্ক্যান রিপোর্ট মুছে ফেলতে চান?'
                          : 'Are you sure you want to clear all saved scan reports?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text(lang.isBangla ? 'বাতিল' : 'Cancel'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.alertRed,
                        ),
                        onPressed: () async {
                          await historyService.clearAllHistory();
                          if (ctx.mounted) Navigator.pop(ctx);
                        },
                        child: Text(lang.isBangla ? 'মুছে ফেলুন' : 'Clear All'),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: historyList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: AppColors.lightGreenBg,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.history_toggle_off_outlined,
                      size: 64,
                      color: AppColors.leafGreen,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    lang.getText('noHistory'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lang.isBangla
                        ? 'আপনার ধান পাতার স্ক্যান করার রিপোর্ট এখানে সংরক্ষিত থাকবে।'
                        : 'Your scanned leaf reports will appear here.',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final item = historyList[index];
                final File imgFile = File(item.imagePath);
                final bool imgExists = imgFile.existsSync();
                final String formattedDate =
                    DateFormat('dd MMM yyyy, hh:mm a').format(item.timestamp);

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(scanResult: item),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          // Thumbnail Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: imgExists
                                  ? Image.file(
                                      imgFile,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      color: AppColors.lightGreenBg,
                                      child: const Icon(
                                        Icons.eco,
                                        color: AppColors.leafGreen,
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Report Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isBn ? item.diseaseNameBn : item.diseaseNameEn,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.auto_awesome,
                                      size: 13,
                                      color: AppColors.leafGreen,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Score: ${item.formattedConfidence}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.leafGreen,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Delete Button
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.grey,
                              size: 20,
                            ),
                            onPressed: () async {
                              await historyService.deleteScanResult(item.id);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
