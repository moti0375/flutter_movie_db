import 'package:flutter/material.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/ui/image_item.dart';

class MediaGridLayout extends StatelessWidget {

  MediaGridLayout({this.items, this.onItemClick});
  final Function(Media) onItemClick;
  final List<Media> items;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height);
    final double itemWidth = size.width;

    return GridView.count(
      shrinkWrap: true,
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      crossAxisCount: 1,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      childAspectRatio: (itemHeight/itemWidth),
      controller: new ScrollController(keepScrollOffset: true),
      children: List.generate(items.length, (index) {
        return ImageItem(
          movie: items[index],
          callback: () {
            print("Clicked ${items[index].title}");
            onItemClick(items[index]);
          },
        );
      }),
    );;
  }
}
