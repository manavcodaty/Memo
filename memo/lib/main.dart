import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';




void main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const MemoApp(
    debugShowCheckedModeBanner: false
  ));
}

class MemoApp extends StatelessWidget {
  const MemoApp({super.key, required bool debugShowCheckedModeBanner});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );

  }
}

  


