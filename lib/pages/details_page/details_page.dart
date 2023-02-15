import 'package:flutter/material.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/repository/tmdb_repository.dart';
import 'package:flutter_movie_db/ui/PlatformAppBar.dart';
import 'package:flutter_movie_db/ui/rating_widget.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage({@required this.media});

  final Media media;
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    print("build: $media");
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: PlatformAppBar(
        title: Text(media.title),
      ).build(context),
      body: _buildContent(media, context),
    );
  }

  Widget getImageOrPlaceHolder(Media movieDetails) {
    if (movieDetails != null) {
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: TmdbRepository.buildImageUrl(movieDetails.poster_path),
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


  Widget _buildContent(Media media, BuildContext context) {
    print("_buildContent: ${media.type}");
    return new Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Hero(
              tag: media.id,
              child: Container(
                child: getImageOrPlaceHolder(media),
              ),
            ),
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .width * 9 / 16,
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
                    media.type == MediaType.tv ? media.genres?.map((genre){
                      return genre.name;
                    })?.toList()?.join(', ') ?? "Genre":
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
