import 'package:flutter/material.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/repository/tmdb_repository.dart';
import 'package:transparent_image/transparent_image.dart';

class MediaGridLayout extends StatelessWidget {
  MediaGridLayout({required this.items, required this.onItemClick}) {
    print("MediaGridLayout: ${this.items.length}");
  }

  final Function(Media) onItemClick;
  final List<Media> items;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    final double itemHeight = itemWidth * 3 / 4;

    print("MediaGridLayout: Height: $itemHeight, Width: $itemWidth");
    return Container(
      child: GridView.count(
        shrinkWrap: true,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        crossAxisCount: items.length % 2 == 0 ? 2 : 3,
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        childAspectRatio: (itemHeight/itemWidth),
        controller: new ScrollController(keepScrollOffset: true),
        children: List.generate(items.length, (index) {
          return Container(
            margin: EdgeInsets.all(4),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0.0, 4.0),
                            color: Colors.black26,
                            blurRadius: 5.0
                        )
                      ]
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Hero(
                    tag: items[index].id,
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: TmdbRepository.buildImageUrl(items[index].poster_path),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      gradient: LinearGradient(colors: [Colors.transparent, Colors.black87], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(bottom: 5, left: 5),
                  child: Text(
                    items[index].title,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white60,
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
