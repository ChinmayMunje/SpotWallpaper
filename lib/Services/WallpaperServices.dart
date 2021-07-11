import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spot_wallpaper_app/Model/Photo_Model.dart';

abstract class WallpaperRepository{
  Future getTrendingWallpapers();
  Future getCategoryWallpaper(String category);
}
class WallpaperServices implements WallpaperRepository{

  int noOfImages = 60;
  List<PhotoModel> photos = new List();

  //Get Trending Wallpapers
  Future getTrendingWallpapers() async {
    String apikey = "563492ad6f917000010000010e57141f30b2437cb7746c1519d63ee5";
    String url1 = "https://api.pexels.com/v1/curated?per_page=$noOfImages&page=1";
    var responseJson;
    var responsejson;
    var headers = {
      'Authorization': apikey,
    };
    var request = http.Request('GET',Uri.parse(url1));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if(response.statusCode == 200){
      responseJson = await http.Response.fromStream(response);
      responsejson = json.decode(responseJson.body);
      return responsejson;
    }else{
      print(response.reasonPhrase);
    }
    print(response.statusCode);
  }

  //Get Category Wallpapers
 Future<dynamic>getCategoryWallpaper(String category) async {
   String apikey = "563492ad6f917000010000010e57141f30b2437cb7746c1519d63ee5";
   String url = "https://api.pexels.com/v1/search?query=${category}&per_page=30&page=1";
    var responseJson;
    var responsejson;
    var headers = {
      'Authorization': apikey,
    };
   var request = http.Request('GET',Uri.parse(url));
   request.headers.addAll(headers);
   http.StreamedResponse response = await request.send();

   if(response.statusCode == 200){
     responseJson = await http.Response.fromStream(response);
     responsejson = json.decode(responseJson.body);
     return responsejson;
   }else{
     print(response.reasonPhrase);
   }
   print(response.statusCode);
  }

  //Get Searched Wallpapers

 Future getSearchWallpaper(String searchQuery) async{
   String apikey = "563492ad6f917000010000010e57141f30b2437cb7746c1519d63ee5";
   String searchURL = "https://api.pexels.com/v1/search?query=$searchQuery&per_page=30&page=1";
   var responseJson;
   var responsejson;
   var headers = {
     'Authorization': apikey,
   };
   var request = http.Request('GET',Uri.parse(searchURL));
   request.headers.addAll(headers);
   http.StreamedResponse response = await request.send();

   if(response.statusCode == 200){
     responseJson = await http.Response.fromStream(response);
     responsejson = json.decode(responseJson.body);
     return responsejson;
   }else{
     print(response.reasonPhrase);
   }
   print(response.statusCode);
 }
}