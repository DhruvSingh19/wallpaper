import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class Full_Screen extends StatefulWidget {
  final String url;
  const Full_Screen({super.key, required this.url});

  @override
  State<Full_Screen> createState() => _Full_ScreenState();
}

class _Full_ScreenState extends State<Full_Screen> {
  setwallpaper() async{
    var location=WallpaperManager.HOME_SCREEN;
    File file=await DefaultCacheManager().getSingleFile(widget.url);
    await WallpaperManager.setWallpaperFromFile(file.path,location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Image.network(widget.url,),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: setwallpaper,
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                      "Set as Wallpaper",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

