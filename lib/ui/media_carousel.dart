import 'package:flutter/material.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/model/media_models.dart';
import 'package:flutter_movie_db/data/repository/tmdb_repository.dart';
import 'package:transparent_image/transparent_image.dart';

class MediaCarousel extends StatelessWidget {
  final MediaModels models;
  final ValueChanged<Media> onClickListener;
  final VoidCallback onMoreClickListener;

  const MediaCarousel({Key key, this.models, this.onClickListener, this.onMoreClickListener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                models.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: onMoreClickListener,
                child: Text(
                  'More',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 3 + 24,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: models.items.length,
              itemBuilder: (context, index) {
                return _buildMediaCell(models.items[index], context);
              }),
        )
      ],
    );
  }

  Widget _buildMediaCell(Media media, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      margin: EdgeInsets.all(10.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${DateTime.parse(media.release_date).year}',
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, letterSpacing: 1.2),
                  ),
                  Text(
                    '${media.vote_average}/10',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 4.0),
                  blurRadius: 6.0,
                )
              ],
            ),
            child: InkWell(
              onTap: () => onClickListener(media),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      child: Hero(
                        tag: media.id,
                        child: FadeInImage.memoryNetwork(
                          width: (MediaQuery
                              .of(context)
                              .size
                              .width / 2),
                          height: (MediaQuery
                              .of(context)
                              .size
                              .width / 2),
                          placeholder: kTransparentImage,
                          image: TmdbRepository.buildImageUrl(media.poster_path),
                          fit: BoxFit.fill,
                        ),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 8, left: 8),
                      width: (MediaQuery
                          .of(context)
                          .size
                          .width / 2),
                      height: (MediaQuery
                          .of(context)
                          .size
                          .width / 2),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        media.title,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          gradient: LinearGradient(colors: [Colors.transparent, Colors.black87], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
