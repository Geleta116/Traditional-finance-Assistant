import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:traditional_financial_asistant/infrastructure/auth/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'domain/auth/AuthFailure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'domain/auth/authenticationRepositoryInterface.dart';
import 'myApp.dart';

class WaitingScreen extends StatefulWidget {
  WaitingScreen() {}

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () async {
      Either<String, int> validationResult =
          await RepositoryProvider.of<AuthenticationRepositroyInterface>(
                  context,
                  listen: false)
              .loggedIn();
      if (validationResult.isRight()) {
        // go to the landing page
        context.goNamed('landing');

        // context.go('/login');
        print('it works');
      } else {
        // go to the login page
       context.goNamed('signup');
        print('not working');
      }
    });

    return Scaffold(
        appBar: AppBar(title: Text('cool')),
        body: ElevatedButton(
          onPressed: () {
            // context.go('/login');
          
          },
          child: Text('touch'),
        ));
  }
}
