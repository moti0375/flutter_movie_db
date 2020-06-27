import 'package:flutter/material.dart';
import 'package:flutter_movie_db/data/model/media_models.dart';
import 'package:flutter_movie_db/data/repository/tmdb_repository.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePageBanner extends StatelessWidget {
  final MediaModels models;

  const HomePageBanner({Key key, this.models}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    PageController controller = PageController(viewportFraction: 0.95, initialPage: 1);

    List<Widget> _buildBannerItems() {
      return models.items
          .map<Widget>((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    print("onTap");
                  },
                  child: Container(
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)), boxShadow: [BoxShadow(color: Colors.black38, offset: Offset(2.0, 2.0), blurRadius: 5.0, spreadRadius: 1.0)]),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          child: Hero(
                            tag: e.id,
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: TmdbRepository.buildImageUrl(e.poster_path),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              gradient: LinearGradient(colors: [Colors.transparent, Colors.black87], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(bottom: 20, left: 20),
                          child: Text(
                            e.title,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white60,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ))
          .toList();
    }

    return Container(
      width: width,
      height: width * 9 / 16,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Now Playing',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => print("Action clicked"),
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
          Expanded(
            child: PageView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              children: _buildBannerItems(),
            ),
          ),
        ],
      ),
    );
  }
}
