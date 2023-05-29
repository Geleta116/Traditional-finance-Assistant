import 'package:flutter/material.dart';
import 'package:traditional_financial_asistant/presentation/Edir/screens/Edir_detail_edir_creator.dart';
import 'package:traditional_financial_asistant/presentation/Edir/screens/Edir_members.dart';
import 'package:traditional_financial_asistant/presentation/Edir/screens/Join_edir.dart';
import 'package:traditional_financial_asistant/presentation/Edir/screens/create_edir.dart';
import 'package:traditional_financial_asistant/presentation/Equb/screens/equb_detail_equb_creator.dart';
import 'package:traditional_financial_asistant/presentation/Equb/screens/members.dart';
import '../presentation/Edir/screens/EdirLandingPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Traditional Financial App',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFDDE5F0)),
      debugShowCheckedModeBanner: false,
      home: JoinEdirScreen(),
    );
  }
}
