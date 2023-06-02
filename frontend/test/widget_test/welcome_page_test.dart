import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:traditional_financial_asistant/presentation/Equb/screens/welcome.dart';
import 'package:traditional_financial_asistant/presentation/utilities/block_button.dart';
// import 'package:your_app/screens/welcome.dart';

void main() {
  testWidgets('Welcome screen displays correctly', (WidgetTester tester) async {
    // Build the widget tree.
    await tester.pumpWidget(MaterialApp(home: Welcome()));

    // Verify that the app bar displays correctly.
    expect(find.text('Traditional Financial Assistant'), findsOneWidget);

    // Verify that the welcome message and image display correctly.
    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('Manage Your Equb and Edir'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Verify that the buttons display correctly.
    expect(find.widgetWithText(BlockButton, 'Equb'), findsOneWidget);
    expect(find.widgetWithText(BlockButton, 'Edir'), findsOneWidget);
    expect(find.widgetWithText(BlockButton, 'My Profile'), findsOneWidget);
  });
}