
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/model/media_category.dart';
import 'package:flutter_movie_db/data/repository/base_service.dart';
import 'package:flutter_movie_db/pages/home_page/bloc.dart';
import 'package:flutter_movie_db/pages/more_page/more_page.dart';
import 'package:flutter_movie_db/ui/PlatformAppBar.dart';
import 'package:flutter_movie_db/ui/home_page_banner.dart';
import 'package:flutter_movie_db/ui/media_carousel.dart';
import 'package:provider/provider.dart';

import '../details_page/details_page.dart';

class HomePage extends StatefulWidget {
  final HomePageBloc bloc;

  const HomePage({Key key, this.bloc}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  static Widget create(BuildContext rootContext) {
    return Consumer<BaseRepository>(
      builder: (_, baseRepository, __) =>
          BlocProvider<HomePageBloc>(
            create: (_) => HomePageBloc(baseRepository),
            child: Consumer<HomePageBloc>(
              builder: (_, bloc, __) =>
                  HomePage(
                    bloc: bloc,
                  ),
            ),
          ),
    );
  }
}

class _HomePageState extends State<HomePage> {

  ValueChanged get onClick => (media) => _navigateToDetailsPage(media);

  ValueChanged get onMoreClickListener => (category) => _navigateToMorePage(category);

  @override
  void initState() {
    super.initState();
    widget.bloc.add(LoadMovies());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildContent(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    PreferredSizeWidget appBar = PlatformAppBar(title: Text("Flutter Movie DB")).build(context);
    return appBar;
  }

  Widget _buildContent() {
    var size = MediaQuery
        .of(context)
        .size;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildNowPlayingBanner(),
            _buildTopRatedCarousel(),
            _buildPopularMoviesCarousel(),
            _buildTvCarousel()
          ],
        ),
      ),
    );
  }

  BlocBuilder<HomePageBloc, HomePageState> _buildTvCarousel() {
    return BlocBuilder<HomePageBloc, HomePageState>(
      condition: (lastState, newState) => newState is TvLoaded,
      builder: (context, state) {
        if (state is TvLoaded) {
          return MediaCarousel(models: state.models, onClickListener: onClick, onMoreClickListener: () => onMoreClickListener(MediaCategory.TvShows),);
        }
        return SizedBox.shrink();
      },
    );
  }


  BlocBuilder<HomePageBloc, HomePageState> _buildPopularMoviesCarousel() {
    return BlocBuilder<HomePageBloc, HomePageState>(
      condition: (lastState, newState) => newState is PopularMoviesLoaded,
      builder: (context, state) {
        if (state is PopularMoviesLoaded) {
          return MediaCarousel(models: state.models, onClickListener: onClick, onMoreClickListener: () => onMoreClickListener(MediaCategory.Popular),);
        }
        return SizedBox.shrink();
      },
    );
  }


  BlocBuilder<HomePageBloc, HomePageState> _buildTopRatedCarousel() {
    return BlocBuilder<HomePageBloc, HomePageState>(
      condition: (lastState, newState) => newState is TopRatedLoaded,
      builder: (context, state) {
        if (state is TopRatedLoaded) {
          return MediaCarousel(models: state.models, onClickListener: onClick, onMoreClickListener: () => onMoreClickListener(MediaCategory.TopRated),);
        }
        return SizedBox.shrink();
      },
    );
  }

  BlocBuilder<HomePageBloc, HomePageState> _buildNowPlayingBanner() {
    return BlocBuilder<HomePageBloc, HomePageState>(
      condition: (lastState, newState) => newState is NowPlayingLoaded,
      builder: (context, state) {
        if (state is NowPlayingLoaded) {
          return HomePageBanner(models: state.models, onClickListener: onClick, onMoreClickListener: () => onMoreClickListener(MediaCategory.NowPlaying),);
        }
        return SizedBox.shrink();
      },
    );
  }

  void _navigateToDetailsPage(Media media) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage(media: media,)));
  }

  void _navigateToMorePage(MediaCategory category) {
    print("_navigateToMorePage: category: $category");
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MorePage.create(category), maintainState: true, settings: RouteSettings()));
  }

}
