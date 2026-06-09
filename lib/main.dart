import 'package:flutter/material.dart';
import 'package:re_manu_past/pages/month_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Re Manu Past',
      home: const MonthView(),
    );
  }
}