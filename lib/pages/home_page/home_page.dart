
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/data/repository/base_service.dart';
import 'package:flutter_movie_db/pages/home_page/bloc.dart';
import 'package:flutter_movie_db/ui/PlatformAppBar.dart';
import 'package:flutter_movie_db/ui/home_page_banner.dart';
import 'package:flutter_movie_db/ui/media_carousel.dart';
import 'package:provider/provider.dart';

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
      padding: EdgeInsets.all(16),
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildNowPlayingBanner(),
            _buildTopRatedCarousel(),
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
          return MediaCarousel(models: state.models,);
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
          return MediaCarousel(models: state.models,);
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
          return HomePageBanner(models: state.models,);
        }
        return SizedBox.shrink();
      },
    );
  }
}
