import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_movie_db/data/model/movie.dart';
import 'package:flutter_movie_db/data/model/movie_details.dart';
import 'package:flutter_movie_db/ui/PlatformAppBar.dart';
import 'package:flutter_movie_db/data/service/tmdb_service.dart';
import 'package:flutter_movie_db/ui/rating_widget.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:transparent_image/transparent_image.dart';


class MovieDetailsModel extends Model{

  MovieDetailsModel({Stream<MovieDetails> stream}){
    stream.listen((data){
      this.details = data;
      notifyListeners();
    });
  }

  MovieDetails details;
}


class DetailsPage extends StatelessWidget {
  DetailsPage({@required this.movie});
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  final Movie movie;

  Widget getImageOrPlaceHolder(MovieDetails movieDetails) {
    if (movieDetails != null) {
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: TmdbService.buildImageUrl(movieDetails.poster_path),
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

  Widget _createStream() {
    return ScopedModelDescendant<MovieDetailsModel>(
      builder: (context, child, model){
        return _buildContent(model.details);
      },
    );
  }

  Widget _buildContent(MovieDetails movieDetails) {

    if(movieDetails == null){
      return _buildProgressBar();
    }

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
              tag: movieDetails.title,
              child: Container(
                height: 300,
                child: getImageOrPlaceHolder(movieDetails),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              movieDetails.title,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "${dateFormat.parse(movieDetails.release_date).year}",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                Text(
                  "${movieDetails.runtime}Min",
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
              movieDetails.overview,
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
            rating: movieDetails.vote_average * 0.5,
            totalVoting: movieDetails.vote_count,
          )
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
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

}
