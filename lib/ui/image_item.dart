import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/service/tmdb_service.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;

class ImageItem extends StatelessWidget {
  ImageItem({this.callback, this.movie});

  final VoidCallback callback;
  final Media movie;

  @override
  Widget build(BuildContext context) {
    Future<Uint8List> _fetchImage(String url) async {
      http.Response response = await http.get(url);
      return response.bodyBytes;
    }

    Widget _loadingWidget(String url) {
      return new FutureBuilder<Uint8List>(
        future: _fetchImage(url),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new Image.memory(
              snapshot.data,
              fit: BoxFit.fill,
            );
          } else if (snapshot.hasError) {
            return new Icon(Icons.broken_image);
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[CircularProgressIndicator()],
            );
          }
        },
      );
//      return FadeInImage.memoryNetwork(
//        placeholder: kTransparentImage,
//        image:
//        "${TmdbService.IMAGES_BASE_URL}/${movie.poster_path}",
//        fit: BoxFit.fill,
//      );
    }

    return InkWell(
      onTap: callback,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                child: Hero(
                  tag: movie.title,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: TmdbService.buildImageUrl(movie.poster_path),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            movie.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          child: Text(
                            movie.release_date,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
