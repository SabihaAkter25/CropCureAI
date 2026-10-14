import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:paddy_disease_detection_app/main.dart';
import 'package:paddy_disease_detection_app/services/api_service.dart';
import 'package:paddy_disease_detection_app/services/history_service.dart';
import 'package:paddy_disease_detection_app/services/language_service.dart';

void main() {
  testWidgets('CropCure AI app loads splash screen test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LanguageService()),
          ChangeNotifierProvider(create: (_) => ApiService()),
          ChangeNotifierProvider(create: (_) => HistoryService()),
        ],
        child: const CropCureApp(),
      ),
    );

    // Verify splash screen branding is shown
    expect(find.text('CropCure AI'), findsWidgets);

    // Advance fake timer to finish splash delay
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
  });
}
