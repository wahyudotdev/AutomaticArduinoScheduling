import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Home.dart';
import 'services/View.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Monitor Ruang',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: CustomColor().primary
        ),
        primarySwatch: Colors.blue,
        backgroundColor: CustomColor().primary,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}
