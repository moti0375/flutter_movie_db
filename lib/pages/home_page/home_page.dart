import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/bloc_cubit/base_state/base_bloc_state.dart';
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

  const HomePage({Key? key, required this.bloc}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  static Widget create(BuildContext rootContext) {
    return Consumer<Repository>(
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
    widget.bloc.loadMovies();
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

  Widget _buildTvCarousel() {
    return BlocBuilder<HomePageBloc, BaseBlocState<HomePageState>>(
      buildWhen: (lastState, newState) => newState.whenOrNull(next: (data) => data.whenOrNull(tvLoaded: (data) => true)) != null,
      builder: (context, baseState) =>
          baseState.when(
            init: () => SizedBox.shrink(),
            loading: () => Container(child: CircularProgressIndicator(),),
            next: (pageState) => pageState.whenOrNull(
                tvLoaded: (models) => MediaCarousel(models: models, onClickListener: onClick, onMoreClickListener: () => onMoreClickListener(MediaCategory.TvShows),)) ?? SizedBox.shrink(),
            error: (e) => SizedBox()));
  }


  Widget _buildPopularMoviesCarousel() {
    return BlocBuilder<HomePageBloc, BaseBlocState<HomePageState>>(
        buildWhen: (lastState, newState) => newState.whenOrNull(next: (data) => data.whenOrNull(popularMoviesLoaded: (data) => true)) != null,
        builder: (context, baseState) =>
            baseState.when(
                init: () => SizedBox.shrink(),
                loading: () => Container(child: CircularProgressIndicator(),),
                next: (pageState) => pageState.whenOrNull(
                    popularMoviesLoaded: (models) => MediaCarousel(models: models, onClickListener: onClick, onMoreClickListener: () => onMoreClickListener(MediaCategory.Popular),)) ?? SizedBox.shrink(),
                error: (e) => SizedBox()));
  }

  Widget _buildTopRatedCarousel() {
    return BlocBuilder<HomePageBloc, BaseBlocState<HomePageState>>(
        buildWhen: (lastState, newState) => newState.whenOrNull(next: (data) => data.whenOrNull(topRatedLoaded: (data) => true)) != null,
        builder: (context, baseState) =>
            baseState.when(
                init: () => SizedBox.shrink(),
                loading: () => Container(child: CircularProgressIndicator(),),
                next: (pageState) => pageState.whenOrNull(
                    topRatedLoaded: (models) => MediaCarousel(models: models, onClickListener: onClick, onMoreClickListener: () => onMoreClickListener(MediaCategory.TopRated),)) ?? SizedBox.shrink(),
                error: (e) => SizedBox()));
  }

  Widget _buildNowPlayingBanner() {
    return BlocBuilder<HomePageBloc, BaseBlocState<HomePageState>>(
        buildWhen: (lastState, newState) => newState.whenOrNull(next: (data) => data.whenOrNull(nowPlayingLoaded: (data) => true)) != null,
        builder: (context, baseState) =>
            baseState.when(
                init: () => SizedBox.shrink(),
                loading: () => Container(child: CircularProgressIndicator(),),
                next: (pageState) => pageState.whenOrNull(
                    nowPlayingLoaded: (models) => HomePageBanner(models: models, onClickListener: onClick, onMoreClickListener: () => onMoreClickListener(MediaCategory.NowPlaying),)) ?? SizedBox.shrink(),
                error: (e) => SizedBox()));
  }

  void _navigateToDetailsPage(Media media) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage.create(media: media)));
  }

  void _navigateToMorePage(MediaCategory category) {
    print("_navigateToMorePage: category: $category");
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MorePage.create(category), maintainState: true, settings: RouteSettings()));
  }

}
