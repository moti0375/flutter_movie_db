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
  BaseService service;
  StreamSubscription _subscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    service = ServiceProvider.of(context).service;
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
          child: _buildContent(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  void getMovies(BaseService service) async {
    print("getMovies");
    _subscription = service.getNowPlaying().listen((data) {
      if (data != null) {
        setState(() {
          this.movies.clear();
          this.movies.addAll(data);
        });
      }
    });
  }

  PreferredSizeWidget _buildAppBar() {
    PreferredSizeWidget appBar =
        PlatformAppBar(title: Text("Flutter Movie DB")).build(context);
    return appBar;
  }

  Widget _buildContent() {
    return StreamBuilder<List<Movie>>(
      stream: service.getNowPlaying(),
      builder: (context, snapshot) {
        return _buildGridLayout(snapshot.data);
      },
    );
  }

  Widget _buildGridLayout(List<Movie> items) {
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
            _loadMovieDetailsAndNavigate(items[index]);
          },
        );
      }),
    );
  }

  void _loadMovieDetailsAndNavigate(Movie movie) {
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
}
