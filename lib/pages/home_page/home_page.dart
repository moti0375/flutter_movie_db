import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_movie_db/data/model/movie.dart';
import 'package:flutter_movie_db/data/service/ServiceProvider.dart';
import 'package:flutter_movie_db/data/service/base_service.dart';
import 'package:flutter_movie_db/data/service/tmdb_service.dart';
import 'package:flutter_movie_db/pages/details_page/details_page.dart';
import 'package:flutter_movie_db/ui/image_item.dart';
import 'dart:async';
import 'package:transparent_image/transparent_image.dart';

import 'package:flutter_movie_db/ui/PlatformAppBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> movies = List<Movie>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BaseService service = ServiceProvider.of(context).service;
    getMovies(service);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: _buildAppBar(),
        body: Container(
          padding: EdgeInsets.all(8),
          child: _buildGridLayout(movies),
        ),
      ),
    );
  }

  void getMovies(BaseService service) async {
    print("getMovies");
    List<Movie> movies = await service.getTopRatedMovies();
    print("movies loaded: ${movies.toString()}");
    if (movies != null) {
      setState(() {
        this.movies.clear();
        this.movies.addAll(movies);
      });
    }
  }

  PreferredSizeWidget _buildAppBar() {
    PreferredSizeWidget appBar =
        PlatformAppBar(title: Text("Flutter Movie DB")).build(context);
    return appBar;
  }

  Widget _buildGridLayout(List<Movie> items) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(items.length, (index) {
        return ImageItem(
          movie: items[index],
          callback: () {
            print("Clicked ${items[index].title}");
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return DetailsPage(movie: items[index]);
            }));
          },
        );
      }),
    );
  }
}
