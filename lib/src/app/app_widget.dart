import 'package:app_nutriocionista/src/pages/home/home_module.dart';
import 'package:flutter/material.dart';


class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Slidy',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomeModule(),
    );
  }
}
