import 'package:flutter/material.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/model/media_models.dart';
import 'package:flutter_movie_db/ui/media_grid_layout.dart';

class MediaItemsLayout extends StatelessWidget {
  MediaItemsLayout({this.medias, this.title, this.onItemClick}) {
    print("MediaItemsLayout: $title");
  }

  final Function(Media) onItemClick;
  final MediaModels medias;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          child: Text(title,
          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
        ),
        MediaGridLayout(
          items: medias.items,
          onItemClick: onItemClick,
        ),
      ],
    );
  }
}
