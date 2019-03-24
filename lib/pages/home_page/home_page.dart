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
import 'package:scoped_model/scoped_model.dart';

class MoviesModel extends Model{
  MoviesModel({Stream<List<Movie>> stream}){
    stream.listen((data){
      this.movies = data;
      notifyListeners();
    });
  }

  List<Movie> movies;
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: _buildAppBar(context),
        body: Container(
          padding: EdgeInsets.all(8),
          child: _buildContent(),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    PreferredSizeWidget appBar =
    PlatformAppBar(title: Text("Flutter Movie DB")).build(context);
    return appBar;
  }

  Widget _buildContent() {
    return ScopedModelDescendant<MoviesModel>(
      builder: (context, child, model){
        return _buildGridLayout(model.movies, context);
      },
    );
  }

  Widget _buildGridLayout(List<Movie> items, BuildContext context) {
    if (items == null) {
      return Container(
        color: Colors.blueGrey,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height);
    final double itemWidth = size.width;

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight),
      controller: new ScrollController(keepScrollOffset: true),
      children: List.generate(items.length, (index) {
        return ImageItem(
          movie: items[index],
          callback: () {
            print("Clicked ${items[index].title}");
            _loadMovieDetailsAndNavigate(items[index], context);
          },
        );
      }),
    );
  }

  void _loadMovieDetailsAndNavigate(Movie movie, BuildContext context) {
    print("_loadMovieDetailsAndNavigate: ${movie.id}");
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {

        BaseService service = ServiceProvider.of(context).service;

        return DetailsPage(
          movieStream: service.getMovieDetails("${movie.id}"),
          movie: movie,
        );
      },
    ));
  }
}

