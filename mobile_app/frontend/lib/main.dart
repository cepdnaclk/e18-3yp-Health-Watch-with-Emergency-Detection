import 'package:flutter/material.dart';
import 'package:my_app_01/navigation.dart';
import 'package:my_app_01/sign_up.dart';
import 'login_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Medi Care',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(""),
    );
  }
}
