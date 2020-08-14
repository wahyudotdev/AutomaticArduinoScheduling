import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web/services/View.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: CustomColor().primary,
      ),
      body: Stack(
        children: [
          Container()
        ],
      ),
    );
  }
}
