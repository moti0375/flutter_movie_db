import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/model/media_models.dart';
import 'package:flutter_movie_db/data/model/movie.dart';
import 'package:flutter_movie_db/data/service/ServiceProvider.dart';
import 'package:flutter_movie_db/data/service/base_service.dart';
import 'package:flutter_movie_db/data/service/tmdb_service.dart';
import 'package:flutter_movie_db/pages/details_page/details_page.dart';
import 'package:flutter_movie_db/ui/image_item.dart';
import 'dart:async';

import 'package:flutter_movie_db/ui/PlatformAppBar.dart';
import 'package:flutter_movie_db/ui/media_grid_layout.dart';
import 'package:flutter_movie_db/ui/media_items_layout.dart';

class HomePage extends StatelessWidget {
  HomePage({this.service});

  final BaseService service;
  final List<Movie> movies = List<Movie>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      left: false,
      right: false,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: _buildAppBar(context),
        body: _buildContent(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    PreferredSizeWidget appBar =
        PlatformAppBar(title: Text("Flutter Movie DB")).build(context);
    return appBar;
  }

  Widget _buildContent() {
    return StreamBuilder<List<MediaModels>>(
      stream: service.getTopRatedMedias(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.data == null ||
            snapshot.data.isEmpty) {
          return _buildLoading();
        } else {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SingleChildScrollView(
                    child: ListView.builder(
                      padding: EdgeInsets.all(2),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        print("ListView.builder: ${snapshot.data.length} items");
                        return MediaItemsLayout(
                          title: snapshot.data[index].title,
                          medias: snapshot.data[index],
                          onItemClick: (media) {
                            _loadMovieDetailsAndNavigate(media, context);
                          },
                        );
                      },
                    ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildGridLayout(List<Media> items, BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height);
    final double itemWidth = size.width;

    return GridView.count(
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      crossAxisCount: 1,
      scrollDirection: Axis.horizontal,
      childAspectRatio: (itemHeight / itemWidth),
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

  void _loadMovieDetailsAndNavigate(Media media, BuildContext context) {
    print("_loadMovieDetailsAndNavigate: ${media.id}, ${media.type}");

    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return DetailsPage(
          movieStream: service.getMediaDetails(media.type, "${media.id}"),
          movie: media,
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
