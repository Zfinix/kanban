import 'package:flutter/material.dart';
import 'package:kanban/utils/theme.dart';

import 'views/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanban',
      theme: themeData(context),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

