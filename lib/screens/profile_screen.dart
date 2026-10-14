import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../services/language_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _urlController;
  bool _isTestingConn = false;
  String? _connStatusMsg;
  bool? _isConnSuccess;

  @override
  void initState() {
    super.initState();
    final api = Provider.of<ApiService>(context, listen: false);
    _urlController = TextEditingController(text: api.endpointUrl);
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _testConnection() async {
    final api = Provider.of<ApiService>(context, listen: false);
    await api.setEndpointUrl(_urlController.text);

    setState(() {
      _isTestingConn = true;
      _connStatusMsg = null;
    });

    final success = await api.testConnection();

    if (mounted) {
      final lang = Provider.of<LanguageService>(context, listen: false);
      setState(() {
        _isTestingConn = false;
        _isConnSuccess = success;
        _connStatusMsg = success
            ? lang.getText('connSuccess')
            : lang.getText('connFail');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageService>(context);
    final apiService = Provider.of<ApiService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.getText('profileTitle')),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Farmer Profile Header Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [AppColors.forestGreen, AppColors.leafGreen],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 34,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 42,
                        color: AppColors.forestGreen,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.getText('farmerName'),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 14,
                                color: AppColors.goldenGrain,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                lang.getText('farmerLocation'),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.agriculture_outlined,
                                size: 14,
                                color: AppColors.goldenGrain,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                lang.getText('farmerCrop'),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.goldenGrain,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Language Selector Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.language, color: AppColors.leafGreen),
                        const SizedBox(width: 10),
                        Text(
                          lang.getText('languageLabel'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ChoiceChip(
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('🇧🇩 '),
                                Text(lang.getText('banglaOption')),
                              ],
                            ),
                            selected: lang.isBangla,
                            selectedColor: AppColors.lightGreenBg,
                            onSelected: (selected) {
                              if (selected) lang.setBangla(true);
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ChoiceChip(
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('🇬🇧 '),
                                Text(lang.getText('englishOption')),
                              ],
                            ),
                            selected: !lang.isBangla,
                            selectedColor: AppColors.lightGreenBg,
                            onSelected: (selected) {
                              if (selected) lang.setBangla(false);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // FastAPI Server Config Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.dns_outlined, color: AppColors.leafGreen),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            lang.getText('serverConfigTitle'),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    Text(
                      lang.getText('serverUrlLabel'),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: _urlController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.save_outlined),
                          onPressed: () async {
                            await apiService.setEndpointUrl(_urlController.text);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Endpoint saved!'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _isTestingConn ? null : _testConnection,
                        icon: _isTestingConn
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.network_check),
                        label: Text(lang.getText('testConnBtn')),
                      ),
                    ),
                    if (_connStatusMsg != null) ...[
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (_isConnSuccess ?? false)
                              ? AppColors.lightGreenBg
                              : AppColors.alertRed.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              (_isConnSuccess ?? false)
                                  ? Icons.check_circle
                                  : Icons.error,
                              color: (_isConnSuccess ?? false)
                                  ? AppColors.leafGreen
                                  : AppColors.alertRed,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _connStatusMsg!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: (_isConnSuccess ?? false)
                                      ? AppColors.darkForest
                                      : AppColors.alertRed,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Krishi Call Center Hotline Card
            Card(
              color: AppColors.goldenGrain.withValues(alpha: 0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: AppColors.goldenGrain, width: 1.2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: AppColors.goldenGrain,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.support_agent,
                        color: AppColors.darkForest,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.getText('helplineTitle'),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkForest,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            lang.getText('helplineSub'),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.forestGreen,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Dialing Krishi Call Center 16123...'),
                          ),
                        );
                      },
                      child: Text(
                        lang.getText('callNow'),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // App Branding & Version
            const CropCureLogo(size: 60, showText: false),
            const SizedBox(height: 8),
            Text(
              lang.getText('appVersion'),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textMuted,
              ),
            ),
            Text(
              lang.getText('appDesc'),
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textMuted,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
