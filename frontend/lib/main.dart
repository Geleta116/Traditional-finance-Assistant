import 'package:flutter/material.dart';
import 'package:traditional_financial_asistant/sync.dart';
import 'myApp.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

main() {
  sqfliteFfiInit();
  runApp(MyApp());
}
