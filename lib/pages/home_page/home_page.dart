
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_movie_db/data/model/movie.dart';
import 'package:flutter_movie_db/data/service/ServiceProvider.dart';
import 'package:flutter_movie_db/data/service/base_service.dart';
import 'package:flutter_movie_db/pages/details_page/details_page.dart';
import 'package:flutter_movie_db/ui/image_item.dart';

import 'package:flutter_movie_db/ui/PlatformAppBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> movies = List<Movie>();
  BaseService service;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    service = ServiceProvider.of(context).service;
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
    List<Movie> movies = await service.getNowPlaying();
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

    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height);
    final double itemWidth = size.width ;


    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight),
      controller: new ScrollController(keepScrollOffset: true),
      children: List.generate(items.length, (index) {
        return ImageItem(
          movie: items[index],
          callback: () {
            print("Clicked ${items[index].title}");
            _loadMovieDetailsAndNavigate("${items[index].id}");
           },
        );
      }),
    );
  }

  void _loadMovieDetailsAndNavigate(String id){
    print("_loadMovieDetailsAndNavigate: $id");
    service.getMovieDetails(id).then((details){
      print("Movie details: ${details.toString()}");
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return DetailsPage(movie: details);
      }));

    });
  }
}
