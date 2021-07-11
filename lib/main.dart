import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spot_wallpaper_app/Home.dart';
import 'package:spot_wallpaper_app/Services/WallpaperServices.dart';
import 'package:spot_wallpaper_app/bloc/Category_Wallpaper/category_bloc.dart';
import 'package:spot_wallpaper_app/bloc/wallpaper_bloc.dart';

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
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context)=> WallpaperBloc(wallpaperRepository: WallpaperServices()),
          ),
          BlocProvider(
            create: (context)=> CategoryBloc(wallpaperRepository: WallpaperServices()),
          ),
        ],
        child: Home(),
      ),
    );
  }
}
