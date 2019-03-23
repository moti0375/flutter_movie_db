import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_movie_db/data/model/movie.dart';
import 'package:flutter_movie_db/data/model/movie_details.dart';
import 'package:flutter_movie_db/ui/PlatformAppBar.dart';
import 'package:flutter_movie_db/data/service/tmdb_service.dart';
import 'package:flutter_movie_db/ui/rating_widget.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({@required this.movieStream});

  final Stream<MovieDetails> movieStream;

  @override
  State<StatefulWidget> createState() {
    return _DetailsPageStateState();
  }
}

class _DetailsPageStateState extends State<DetailsPage> {
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  MovieDetails movieDetails;
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = widget.movieStream.listen((details){
      setState(() {
        this.movieDetails = details;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: PlatformAppBar(
        title: Text(movieDetails != null ? movieDetails.title : ""),
      ).build(context),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: 250,
              child: Hero(
                tag: movieDetails != null ? movieDetails.title : "",
                child: Container(
                  height: 300,
                  child: getImageOrPlaceHolder(),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                movieDetails != null ? movieDetails.title : "",
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black.withOpacity(0.6)),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    movieDetails != null ? "${dateFormat.parse(movieDetails.release_date).year}" : "",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    movieDetails != null ? "${movieDetails.runtime}Min" : "",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.6),
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
                movieDetails != null ? movieDetails.overview : "",
                textAlign: TextAlign.left,
                softWrap: true,
                style: TextStyle(
                    fontSize: 15, color: Colors.black.withOpacity(0.6)),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            RatingWidget(
              rating: movieDetails != null ? movieDetails.vote_average * 0.5 : 0,
              totalVoting: movieDetails != null ? movieDetails.vote_count : 0,
            )
          ],
        ),
      ),
    );
  }

  Widget getImageOrPlaceHolder(){
    if(movieDetails != null){
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image:TmdbService.buildImageUrl(movieDetails.poster_path),
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
}
