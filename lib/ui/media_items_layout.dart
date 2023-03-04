import 'package:flutter/material.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/model/media_models.dart';

import 'image_item.dart';

class MediaItemsLayout extends StatelessWidget {
  MediaItemsLayout({required this.medias, required this.title, required this.onItemClick}) {
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
          child: Text(
            title,
            style: TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .width * 9 / 16,
                      child: Card(
                        child: ImageItem(
                          movie: medias.items[index],
                          callback: () {
                            print("Clicked ${medias.items[index].title}");
                            onItemClick(medias.items[index]);
                          },
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => Divider(),
                itemCount: medias.items.length,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
