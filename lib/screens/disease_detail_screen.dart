import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/disease.dart';
import '../services/language_service.dart';
import '../theme/app_theme.dart';

class DiseaseDetailScreen extends StatelessWidget {
  final Disease disease;

  const DiseaseDetailScreen({super.key, required this.disease});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context);
    final bool isBn = lang.isBangla;

    return Scaffold(
      appBar: AppBar(
        title: Text(disease.getName(isBn)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    disease.severity == 'high'
                        ? const Color(0xFF9E2A2B)
                        : disease.severity == 'medium'
                            ? const Color(0xFFD97706)
                            : AppColors.leafGreen,
                    AppColors.forestGreen,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.forestGreen.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          disease.getName(isBn),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          disease.severity == 'healthy'
                              ? 'HEALTHY'
                              : '${disease.severity.toUpperCase()} SEVERITY',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    disease.scientificName,
                    style: const TextStyle(
                      color: AppColors.goldenGrain,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    disease.getDescription(isBn),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Symptoms Section
            _buildSectionCard(
              title: lang.getText('symptomsLabel'),
              icon: Icons.sick_outlined,
              iconColor: AppColors.warmAmber,
              content: Column(
                children: disease.getSymptoms(isBn).map((symptom) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.fiber_manual_record,
                          size: 10,
                          color: AppColors.warmAmber,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            symptom,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textDark,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Causes Section
            _buildSectionCard(
              title: lang.getText('causesLabel'),
              icon: Icons.bug_report_outlined,
              iconColor: AppColors.alertRed,
              content: Text(
                disease.getCauses(isBn),
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textDark,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Verified Treatment & Remedies
            _buildSectionCard(
              title: lang.getText('treatmentLabel'),
              icon: Icons.medication_liquid_outlined,
              iconColor: AppColors.leafGreen,
              content: Column(
                children: disease.getTreatment(isBn).map((item) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreenBg.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.accentGreen.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.verified,
                          size: 18,
                          color: AppColors.leafGreen,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkForest,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Prevention Section
            _buildSectionCard(
              title: lang.getText('preventionLabel'),
              icon: Icons.shield_outlined,
              iconColor: AppColors.brightGreen,
              content: Column(
                children: disease.getPrevention(isBn).map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          size: 16,
                          color: AppColors.brightGreen,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textDark,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget content,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.forestGreen,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 20, color: AppColors.borderLight),
            content,
          ],
        ),
      ),
    );
  }
}
