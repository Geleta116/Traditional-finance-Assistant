import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:traditional_financial_asistant/presentation/Equb/screens/equb_detail_equb_creator.dart';
import 'package:traditional_financial_asistant/presentation/utilities/block_button.dart';
// import 'package:your_app/equb_detail_equb_creator_screen.dart';

void main() {

  testWidgets('Equb Detail Equb Creator Screen Widget Test', (WidgetTester tester) async {
    
    // Build Equb Detail Equb Creator Screen widget
    await tester.pumpWidget(MaterialApp(home: EqubDetailEqubCreatorScreen()));

    // Check if the Equb Name text is displayed
    expect(find.text('Equb Name'), findsNWidgets(2));

    // Check if the Members button is displayed
    expect(find.widgetWithText(BlockButton, 'Members'), findsOneWidget);

    // Check if the Blacklist button is displayed
    expect(find.widgetWithText(BlockButton, 'Blacklist'), findsOneWidget);
    
  });
}