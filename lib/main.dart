import 'package:flutter/material.dart';

import 'homescreen.dart';
void main()=> runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    home: wallpaper_app(),
    );
  }
}



