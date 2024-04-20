import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/full_screen.dart';

class wallpaper_app extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePage();
  }
}

class HomePage extends State<wallpaper_app> {
  List images = [];
  int page = 1;

  fetch_api() async {
    await http.get(
        Uri.parse('https://api.pexels.com/v1/curated?per_page=80&page=1'),
        headers: {
          'Authorization':
              'IE1AUqkoWXIKsOg8cuaEuQ8VH9e74jL4NaC8ppRAeamHomBu25TASyWV',
        }).then((value) {
      Map result = jsonDecode(value.body);
      images += result['photos'];
    });
  }

  loadmore() async {
    setState(() {
      page++;
    });
    String url =
        "https://api.pexels.com/v1/curated?per_page=80&page=" + page.toString();
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          'IE1AUqkoWXIKsOg8cuaEuQ8VH9e74jL4NaC8ppRAeamHomBu25TASyWV',
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images += result['photos'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetch_api();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: FutureBuilder(
                future: fetch_api(),
                builder: (context, index) {
                  return
                  GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4,
                        childAspectRatio: 2 / 3,
                        mainAxisSpacing: 4,
                      ),
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>Full_Screen(url: images[index]['src']['large2x'])));
                          },
                          child: Container(
                            color: Colors.black,
                            child: Image.network(
                              images[index]['src']['tiny'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      });
                },
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: loadmore,
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    "Load More",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
