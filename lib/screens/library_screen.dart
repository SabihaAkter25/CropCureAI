import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/disease.dart';
import '../services/language_service.dart';
import '../theme/app_theme.dart';
import 'disease_detail_screen.dart';

class DiseaseLibraryScreen extends StatefulWidget {
  const DiseaseLibraryScreen({super.key});

  @override
  State<DiseaseLibraryScreen> createState() => _DiseaseLibraryScreenState();
}

class _DiseaseLibraryScreenState extends State<DiseaseLibraryScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context);
    final bool isBn = lang.isBangla;

    final List<Disease> filteredDiseases = Disease.diseaseLibrary.where((d) {
      final nameEn = d.nameEn.toLowerCase();
      final nameBn = d.nameBn.toLowerCase();
      final q = _searchQuery.toLowerCase();
      return nameEn.contains(q) || nameBn.contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.getText('libraryTitle')),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
              decoration: InputDecoration(
                hintText: lang.getText('searchHint'),
                prefixIcon: const Icon(Icons.search, color: AppColors.leafGreen),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.borderLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColors.leafGreen,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),

          // Diseases List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: filteredDiseases.length,
              itemBuilder: (context, index) {
                final disease = filteredDiseases[index];
                final bool isHealthy = disease.severity == 'healthy';

                return Card(
                  margin: const EdgeInsets.only(bottom: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: isHealthy
                          ? AppColors.brightGreen
                          : AppColors.borderLight,
                      width: isHealthy ? 1.5 : 0.8,
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DiseaseDetailScreen(disease: disease),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          // Disease Badge Icon
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: isHealthy
                                  ? AppColors.lightGreenBg
                                  : disease.severity == 'high'
                                      ? AppColors.alertRed.withValues(alpha: 0.12)
                                      : AppColors.warmAmber.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isHealthy ? Icons.eco : Icons.coronavirus_outlined,
                              color: isHealthy
                                  ? AppColors.leafGreen
                                  : disease.severity == 'high'
                                      ? AppColors.alertRed
                                      : AppColors.warmAmber,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 14),

                          // Text Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  disease.getName(isBn),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  disease.scientificName,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textMuted,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isHealthy
                                        ? AppColors.lightGreenBg
                                        : AppColors.softCream,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    isHealthy
                                        ? (isBn ? 'নীরোগ' : 'Healthy Crop')
                                        : (isBn
                                            ? 'ঝুঁকি: ${disease.severity == "high" ? "উচ্চ" : "মাঝারি"}'
                                            : 'Severity: ${disease.severity.toUpperCase()}'),
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: isHealthy
                                          ? AppColors.leafGreen
                                          : disease.severity == 'high'
                                              ? AppColors.alertRed
                                              : AppColors.textMuted,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Icon(
                            Icons.chevron_right,
                            color: AppColors.textMuted,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
