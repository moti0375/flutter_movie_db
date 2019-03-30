import 'package:flutter/material.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/ui/media_grid_layout.dart';

class MediaItemsLayout extends StatelessWidget {
  MediaItemsLayout({this.items, this.title, this.onItemClick});

  final Function(Media) onItemClick;
  final List<Media> items;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: MediaGridLayout(
              items: items,
              onItemClick: onItemClick,
            ),
          )
        ],
      ),
    );
  }
}
