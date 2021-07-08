import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:spot_wallpaper_app/Category_screen.dart';
import 'package:spot_wallpaper_app/Model/Photo_Model.dart';
import 'package:spot_wallpaper_app/Search_View.dart';
import 'package:spot_wallpaper_app/Services/WallpaperServices.dart';
import 'package:spot_wallpaper_app/data/category_data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WallpaperServices services;
  var wallpaperDetail;

  List<CategoryModel> category = List<CategoryModel>();
  List<PhotoModel> photos = new List();
  int noOfImages = 60;

  @override
  void initState() {
    services = WallpaperServices();
    getTrendingWallpaper();
    category = getCategory();
    super.initState();

    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        noOfImages = noOfImages + 60;
        getTrendingWallpaper();
      }
    });

  }

  TextEditingController searchController = new TextEditingController();
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Spot",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 23),),
            Text("Wallpaper",style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.w600, fontSize: 23),),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 24),

                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        style: TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                            hintText: 'search wallpaper',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        if(searchController.text != ""){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Search_View(
                            search: searchController.text,
                          )));
                        }
                      },
                      child: Container(child: Icon(Icons.search,color: Colors.grey)),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              //Category

              Container(
                height: 70,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category.length,
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        imgUrl: category[index].imgUrl,
                        categoryName: category[index].categoryName,
                      );
                    }
                ),
              ),
              wallpaper(photos, context, noOfImages),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> getTrendingWallpaper() async{
    wallpaperDetail = await services.getTrendingWallpapers();
    if(wallpaperDetail != Null){
      wallpaperDetail["photos"].forEach((element){
        PhotoModel photoModel = new PhotoModel();
              photoModel = PhotoModel.fromMap(element);
              photos.add(photoModel);
      });
      setState(() {
        int dat=photos.length;
              print("lenght = $dat");
              print( wallpaperDetail.length);
      });
    }
  }
}


class CategoryModel{
  String imgUrl;
  String categoryName;

}

class CategoryCard extends StatelessWidget {
  final String imgUrl;
  final String categoryName;

  CategoryCard({this.imgUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen(category: categoryName)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                imageBuilder: (context, imageProvider)=> Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 60,
                  width: 120,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

