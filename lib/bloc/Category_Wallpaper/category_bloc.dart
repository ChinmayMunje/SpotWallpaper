

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spot_wallpaper_app/Home.dart';
import 'package:spot_wallpaper_app/Model/Photo_Model.dart';
import 'package:spot_wallpaper_app/Services/WallpaperServices.dart';
import 'package:spot_wallpaper_app/bloc/Category_Wallpaper/category_event.dart';
import 'package:spot_wallpaper_app/bloc/Category_Wallpaper/category_state.dart';
import 'package:spot_wallpaper_app/bloc/wallpaper_event.dart';
import 'package:spot_wallpaper_app/bloc/wallpaper_state.dart';

class CategoryBloc extends Bloc<CategoryEvents,CategoryState>{
  String category;
  WallpaperRepository wallpaperRepository;
  CategoryBloc({@required this.wallpaperRepository}) : super(null);

  @override
  Stream<CategoryState> mapEventToState(CategoryEvents event) async*{
    if(event is FetchWallpaperEvents){
      yield CategoryLoadingState();
      try{
        List<CategoryModel> categoryModel = await wallpaperRepository.getCategoryWallpaper(category);
        yield CategoryLoadedState(categoryModel: categoryModel);
      }catch (e){
        yield CategoryErrorState(message: e.toString());
      }
    }
  }
}