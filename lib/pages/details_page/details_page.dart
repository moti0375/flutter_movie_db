import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/bloc_cubit/base_state/base_bloc_state.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/repository/base_service.dart';
import 'package:flutter_movie_db/data/repository/tmdb_repository.dart';
import 'package:flutter_movie_db/pages/details_page/details_page_cubit.dart';
import 'package:flutter_movie_db/pages/details_page/details_page_state/details_page_state.dart';
import 'package:flutter_movie_db/ui/PlatformAppBar.dart';
import 'package:flutter_movie_db/ui/rating_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({required this.media, required this.cubit});

  final Media media;
  final DetailsPageCubit cubit;

  @override
  State<DetailsPage> createState() => _DetailsPageState();

  static Widget create({required Media media}) {
    return Consumer<Repository>(
      builder: (_, baseRepository, __) => BlocProvider<DetailsPageCubit>(
        create: (_) => DetailsPageCubit(baseRepository, media),
        child: Consumer<DetailsPageCubit>(
          builder: (_, bloc, __) => DetailsPage(
            cubit: bloc,
            media: media,
          ),
        ),
      ),
    );
  }
}

class _DetailsPageState extends State<DetailsPage> {
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();
    widget.cubit.loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    print("build: ${widget.media}");
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: PlatformAppBar(
        title: Text(widget.media.title),
      ).build(context),
      body: BlocBuilder<DetailsPageCubit, BaseBlocState<DetailsPageState>>(
        builder: (context, state) {
          return state.map(
              init: (_) => SizedBox(),
              loading: (_) => _loadingWidget(),
              next: (pageState) => _showDetailsPage(pageState.data, context),
              error: (state) => _handleError(state.error));
        },
      ),
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

  Widget _showDetailsPage(DetailsPageState data, BuildContext context) {
    return data.map(detailsLoaded: (detailsLoaded) => _buildContent(detailsLoaded.details, context));
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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 9 / 16,
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
                    media.release_date != null ? "${dateFormat.parse(media.release_date!).year}" : "",
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
                    media.type == MediaType.tv
                        ? media.genres
                                ?.map((genre) {
                                  return genre.name;
                                })
                                .toList()
                                .join(', ') ??
                            "Genre"
                        : "${media.runtime}Min",
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

  Widget _handleError(Error error) {
    return Container(
      child: Center(
        child: Text("Something went wrong: ${error.stackTrace}"),
      ),
    );
  }


}
