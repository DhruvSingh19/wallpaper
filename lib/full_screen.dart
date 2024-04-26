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
  var location;
  setwallpaper(int index) async {
    switch (index) {
      case 1:
        location = WallpaperManager.HOME_SCREEN;
        break;
      case 2:
        location = WallpaperManager.LOCK_SCREEN;
        break;
      case 3:
        location = WallpaperManager.BOTH_SCREEN;
        break;
    }
    File file = await DefaultCacheManager().getSingleFile(widget.url);
    await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  void _showdialogue() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Select any one"),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  setwallpaper(1);
                  Navigator.pop(context);
                },
                child: Text("Home Screen"),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setwallpaper(2);
                  Navigator.pop(context);
                },
                child: Text("Lock Screen"),
              ),
              SimpleDialogOption(
                onPressed: () {
                  setwallpaper(3);
                  Navigator.pop(context);
                },
                child: Text("Both Screens"),
              )
            ],
          );
        });
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
                child: Image.network(
                  widget.url,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                _showdialogue();
              },
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
