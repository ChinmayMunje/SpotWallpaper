import 'package:flutter/material.dart';
import 'package:spot_wallpaper_app/Home.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Spot Wallpaper",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Home(),
    );
  }
}
