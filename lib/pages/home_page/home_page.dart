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

import 'package:flutter_movie_db/ui/PlatformAppBar.dart';

class HomePage extends StatelessWidget {
  HomePage({this.service});
  final BaseService service;
  final List<Movie> movies = List<Movie>();


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
    return StreamBuilder<List<Movie>>(
      stream: service.getNowPlaying(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return _buildLoading();
        } else {
          return _buildGridLayout(snapshot.data, context);
        }

      },
    );
  }

  Widget _buildGridLayout(List<Movie> items , BuildContext context) {

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
        return DetailsPage(
          movieStream: service.getMovieDetails("${movie.id}"),
          movie: movie,
        );
      },
    ));
  }

  Widget _buildLoading() {
    return Container(
      color: Colors.white,
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
}
