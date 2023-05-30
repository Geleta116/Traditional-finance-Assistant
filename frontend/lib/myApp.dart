import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traditional_financial_asistant/application/register/signup_bloc.dart';
import 'package:traditional_financial_asistant/domain/auth/authenticationRepositoryInterface.dart';
import 'package:traditional_financial_asistant/domain/register/signUpRepositoryInterface.dart';
import 'package:traditional_financial_asistant/infrastructure/ekub/Ekub_repository.dart';
import 'package:traditional_financial_asistant/infrastructure/join/join_data_provider.dart';
import 'package:traditional_financial_asistant/infrastructure/join/join_repository.dart';
import 'package:traditional_financial_asistant/infrastructure/register/signup_repository.dart';
import 'package:traditional_financial_asistant/infrastructure/auth/authentication_repository.dart';
import 'package:traditional_financial_asistant/infrastructure/ekub/Ekub_repository.dart';
import 'package:traditional_financial_asistant/infrastructure/register/signup_provider.dart';
import 'package:traditional_financial_asistant/infrastructure/auth/authentication_provider.dart';
import 'package:traditional_financial_asistant/infrastructure/ekub/Ekub_data_provider.dart';
import 'package:traditional_financial_asistant/domain/ekub/ekubRepositoryInterface.dart';
import 'package:traditional_financial_asistant/infrastructure/ekub/Ekub_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:traditional_financial_asistant/presentation/equb/screens/EqubLandingPage.dart';
import 'package:traditional_financial_asistant/presentation/equb/screens/joinEqub.dart';
import 'package:traditional_financial_asistant/waiting_screen.dart';
import 'application/auth/authentication_bloc.dart';
import 'application/ekub/ekub_bloc.dart';
import 'application/join/join_bloc.dart';
import 'domain/join/joinRepositoryInterface.dart';
import 'routing.dart';
import 'package:traditional_financial_asistant/presentation/equb/screens/createEqub.dart';
import 'package:traditional_financial_asistant/presentation/auth/login.dart';
import 'package:traditional_financial_asistant/presentation/register/signup_screen.dart';
import 'package:traditional_financial_asistant/welcome.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  final appRouting = GoRouter(routes: [
    GoRoute(
      path: '/',
      name: 'waiting',

      builder: (context, state) => WaitingScreen(),
    ),
    GoRoute(
        path: "/login", name: "login", builder: (context, state) => Login()),

    GoRoute(
        path: "/signup",
        name: "signup",
        builder: (context, state) => SignupScreen()),

    GoRoute(
        path: "/createEkub",
        name: "createEkub",
        builder: (context, state) => CreateEqubScreen()),
    GoRoute(
        path: "/joinEkub",
        name: "joinEkub",
        builder: (context, state) => JoinEqubScreen()),
    GoRoute(
        path: "/ekubLanding",
        name: "ekubLanding",
        builder: (context, state) => EqubLandingPage()),
    GoRoute(
        path: "/landing",
        name: "landing",
        builder: (context, state) => Welcome())
  ]);

  AuthenticationRepositroyInterface _authRepository =
      AuthenticationRepository(AuthenticationProvider());
  SignUpRepositoryInterface _signUPRepository =
      SignUpRepository(SignUpDataProvider());
  EkubRepositoryInterface _ekubRepository = EkubRepository(EkubDataProvider());
  JoinRepositoryInterface _joinRepository =
      JoinRepository(JoinDataProvider());


  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepositroyInterface>(
          create: (context) => _authRepository,
        ),
        RepositoryProvider<SignUpRepositoryInterface>(
          create: (context) => _signUPRepository,
        ),
        RepositoryProvider<EkubRepositoryInterface>(
          create: (context) => _ekubRepository,
        ),

        RepositoryProvider<JoinRepositoryInterface>(
          create: (context) => _joinRepository,
        ),

      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(_authRepository),
            ),


            BlocProvider<JoinBloc>(
              create: (context) => JoinBloc(
                joinRepository: _joinRepository),
            ),

            BlocProvider<SignupBloc>(
              create: (context) => SignupBloc(
                signupRepository: _signUPRepository,
              ),
            ),
            BlocProvider<EkubBloc>(
              create: (context) => EkubBloc(
                ekubRepository: _ekubRepository,
              ),
            ),
          ],
          child: MaterialApp.router(
            title: 'Traditional Finance Assistant',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routeInformationParser: appRouting.routeInformationParser,
            routerDelegate: appRouting.routerDelegate,
          )),
    );
  }
}