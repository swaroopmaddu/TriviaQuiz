import 'package:flutter/material.dart';
import 'package:quiz/views/home.dart';
import 'package:quiz/views/quizpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'BalooTamma',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/home': (context) => HomePage(),
        '/quiz': (context) => Quiz(),
      },
      initialRoute: '/home',
    );
  }
}
