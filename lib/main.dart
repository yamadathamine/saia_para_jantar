import 'package:flutter/material.dart';
import 'package:saia_para_jantar/screen/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saia para Jantar',
      theme: ThemeData(primarySwatch: Colors.blue,),
      home: Home(),
    );
  }
}


