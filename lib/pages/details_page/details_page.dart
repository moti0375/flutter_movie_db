import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/repository/tmdb_repository.dart';
import 'package:flutter_movie_db/ui/PlatformAppBar.dart';
import 'package:flutter_movie_db/ui/rating_widget.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({@required this.movieStream, @required this.movie});

  final Stream<Media> movieStream;
  final Media movie;
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: PlatformAppBar(
        title: Text(movie.title),
      ).build(context),
      body: _createStream(),
    );
  }

  Widget getImageOrPlaceHolder(Media movieDetails) {
    if (movieDetails != null) {
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: TmdbRepository.buildImageUrl(movieDetails.backdrop_path),
        fit: BoxFit.fill,
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
        ],
      );
    }
  }

  Widget _createStream() {
    return StreamBuilder<Media>(
        stream: movieStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _loadingWidget();
          } else {
            return _buildContent(snapshot.data);
          }
        });
  }

  Widget _buildContent(Media media) {
    print("_buildContent: ${media.type}");
    return new Container(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 250,
            child: Hero(
              tag: media.title,
              child: Container(
                height: 300,
                child: getImageOrPlaceHolder(media),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              media.title,
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    "${dateFormat.parse(media.release_date).year}",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    media.type == MediaType.tv ? media.genres.map((genre){
                      return genre.name;
                    }).toList().join(', ') :
                    "${media.runtime}Min",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              media.overview,
              textAlign: TextAlign.left,
              softWrap: true,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          RatingWidget(
            rating: media.vote_average * 0.5,
            totalVoting: media.vote_count,
          )
        ],
      ),
    );
  }

  Widget _loadingWidget() {
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
