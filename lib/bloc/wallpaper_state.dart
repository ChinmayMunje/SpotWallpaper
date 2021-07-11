
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spot_wallpaper_app/Model/Photo_Model.dart';

abstract class WallpaperState extends Equatable{}

class WallpaperInitialState extends WallpaperState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WallpaperLoadingState extends WallpaperState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WallpaperLoadedState extends WallpaperState {

  List<PhotoModel> photos;

  WallpaperLoadedState({@required this.photos});

  @override
  // TODO: implement props
  List<Object> get props => [photos];
}

class WallpaperErrorState extends WallpaperState {

  String message;

  WallpaperErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}


