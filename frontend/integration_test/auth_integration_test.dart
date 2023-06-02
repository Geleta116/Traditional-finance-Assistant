import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:traditional_financial_asistant/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('sign up',
        (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 4, milliseconds: 500));

    

  
      await tester.pumpAndSettle();

      final signUpButton = find.byKey(Key('sign_up'));
      await tester.enterText(find.byKey(Key("fullName")), "name");
      await tester.enterText(find.byKey(Key("username")), "namekena1");
      await tester.enterText(find.byKey(Key("password")), "Name@123");
      await tester.enterText(find.byKey(Key("email")), "Name@gmail.com");
      await tester.enterText(find.byKey(Key("balance")), "1000");

      
      await tester.dragUntilVisible(
            signUpButton, 
            find.byType(SingleChildScrollView), 
            const Offset(0, 50), 
      );

      await tester.pumpAndSettle(const Duration(seconds: 5));
      await Future.delayed(const Duration(seconds: 2));
    });
  });

    testWidgets('login', (tester) async {
        app.main();
        await tester.pumpAndSettle(const Duration(seconds: 4, milliseconds: 500));

        final loginButton = find.byKey(const Key('login'));

        await tester.tap(loginButton);
        await tester.pumpAndSettle();

        final username = find.byKey(const Key('username'));
        final password = find.byKey(const Key('password'));
        final signInButton = find.byKey(const Key('login_user'));

        await tester.tap(username);
        await tester.enterText(username, "namekena1");

        await tester.tap(password);
        await tester.enterText(password, "Name@123");

        // await tester.tap(signInButton);
        await tester.dragUntilVisible(
            signInButton, 
            find.byType(SingleChildScrollView), 
            const Offset(0, 50), 
      );

        await tester.pumpAndSettle(const Duration(seconds: 5));
        await Future.delayed(const Duration(seconds: 2));

      });

    testWidgets('business feature #1: create ekub', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 6, milliseconds: 500));

      final EkubButton = find.byKey(Key('ekub'));

      await tester.tap(EkubButton);
      await tester.pumpAndSettle();

      final createEkubBtn = find.byKey(const Key('create_ekub'));
      expect(createEkubBtn, findsOneWidget);


      final ekubName = find.byKey(const Key('equbNameInput'));
      final amount = find.byKey(const Key('amountInput'));
      final countdown = find.byKey(const Key('countdownInput'));
      final duration = find.byKey(const Key('durationInput'));
      final minMembers = find.byKey(const Key('amount'));
      final description = find.byKey(const Key('minMembersInput'));
      final ekubBtn = find.byKey(Key('create_ekub_button'));


      await tester.tap(ekubName);
      await tester.enterText(ekubName, "Ekub name");

      await tester.tap(description);
      await tester.enterText(description, "Description");
      await tester.tap(amount);
      await tester.enterText(amount, "1000");
      await tester.tap(countdown);
      await tester.enterText(countdown, "5");
      await tester.tap(duration);
      await tester.enterText(duration, "5");
      await tester.tap(minMembers);
      await tester.enterText(minMembers, "10");

      await tester.tap(createEkubBtn);

      await tester.pumpAndSettle(const Duration(seconds: 2));
      await Future.delayed(const Duration(seconds: 2));
    });

}