
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spot_wallpaper_app/Home.dart';
import 'package:spot_wallpaper_app/Model/Photo_Model.dart';

abstract class CategoryState extends Equatable{}

class CategoryInitialState extends CategoryState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CategoryLoadingState extends CategoryState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CategoryLoadedState extends CategoryState {

  List<CategoryModel> categoryModel;

  CategoryLoadedState({@required this.categoryModel});

  @override
  // TODO: implement props
  List<Object> get props => [categoryModel];
}

class CategoryErrorState extends CategoryState {

  String message;

  CategoryErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}


