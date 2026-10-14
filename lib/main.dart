import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'services/api_service.dart';
import 'services/history_service.dart';
import 'services/language_service.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageService()),
        ChangeNotifierProvider(create: (_) => ApiService()),
        ChangeNotifierProvider(create: (_) => HistoryService()),
      ],
      child: const CropCureApp(),
    ),
  );
}

class CropCureApp extends StatefulWidget {
  const CropCureApp({super.key});

  @override
  State<CropCureApp> createState() => _CropCureAppState();
}

class _CropCureAppState extends State<CropCureApp> {
  bool _showSplash = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CropCure AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: _showSplash
          ? SplashScreen(
              onFinish: () {
                setState(() {
                  _showSplash = false;
                });
              },
            )
          : const HomeScreen(),
    );
  }
}
