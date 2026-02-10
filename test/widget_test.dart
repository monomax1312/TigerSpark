
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tiger_spark/app.dart';
import 'package:tiger_spark/core/di/injection.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await setupInjection();
  });

  testWidgets('App builds and shows home', (WidgetTester tester) async {
    await tester.pumpWidget(const TigerSparkApp());
    await tester.pumpAndSettle();

    expect(find.text('Tiger Spark'), findsOneWidget);
  });
}
