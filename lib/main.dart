import 'package:animation/day1.dart';
import 'package:animation/day2.dart';
import 'package:animation/day3.dart';
import 'package:animation/day4.dart';
import 'package:animation/day5.dart';
import 'package:animation/flip_card.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData.dark(useMaterial3: true),
      home: const Day5(),
      debugShowCheckedModeBanner: false,
    );
  }
}
