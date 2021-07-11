import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spot_wallpaper_app/Model/Photo_Model.dart';
import 'package:spot_wallpaper_app/Services/WallpaperServices.dart';
import 'package:spot_wallpaper_app/bloc/wallpaper_event.dart';
import 'package:spot_wallpaper_app/bloc/wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvents,WallpaperState>{
  WallpaperRepository wallpaperRepository;
  WallpaperBloc({@required this.wallpaperRepository}) : super(null);

  @override
  Stream<WallpaperState> mapEventToState(WallpaperEvents event) async*{
   if(event is FetchWallpaperEvents){
     yield WallpaperLoadingState();
     try{
       List<PhotoModel> photoModel = await wallpaperRepository.getTrendingWallpapers();
       yield WallpaperLoadedState(photos: photoModel);
     }catch (e){
       yield WallpaperErrorState(message: e.toString());
     }
   }
  }
}