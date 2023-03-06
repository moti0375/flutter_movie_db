import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/bloc_cubit/base_state/base_bloc_state.dart';
import 'package:flutter_movie_db/data/model/media.dart';
import 'package:flutter_movie_db/data/model/media_category.dart';
import 'package:flutter_movie_db/data/repository/base_service.dart';
import 'package:flutter_movie_db/pages/details_page/details_page.dart';
import 'package:flutter_movie_db/pages/more_page/bloc.dart';
import 'package:flutter_movie_db/pages/more_page/more_page_bloc.dart';
import 'package:flutter_movie_db/ui/PlatformAppBar.dart';
import 'package:flutter_movie_db/ui/media_grid_layout.dart';
import 'package:provider/provider.dart';

class MorePage extends StatefulWidget {
  final MorePageBloc bloc;

  const MorePage({Key? key, required this.bloc}) : super(key: key);

  @override
  _MorePageState createState() => _MorePageState();

  static Widget create(MediaCategory category) {
    return Consumer<Repository>(
      builder: (c, repo, __) =>
          BlocProvider<MorePageBloc>(
            create: (c) => MorePageBloc(repo, category),
            child: Consumer<MorePageBloc>(
              builder: (_, bloc, __) =>
                  MorePage(
                    bloc: bloc,
                  ),
            ),
          ),
    );
  }
}

class _MorePageState extends State<MorePage> {
  @override
  void initState() {
    super.initState();
    widget.bloc.loadMedias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformAppBar(
        title: Text("More"),
      ).build(context),
      body: BlocBuilder<MorePageBloc, BaseBlocState<MorePageState>>(builder: (context, state) {
        return state.map(init: (_) => SizedBox.shrink(),
            loading: (_) => _showProgressIndicator(),
            next: (pageState) => _handlePageState(pageState.data),
            error: (errorState) => _showError(errorState.error));
      }),
    );
  }

  Widget _handlePageState(MorePageState pageState) {
    return pageState.map(moreLoaded: (moreLoaded) => _buildContent(moreLoaded.items));
  }

  Widget _buildContent(List<Media> items) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: MediaGridLayout(
        items: items,
        onItemClick: (media) {
          _navigateToDetailsPage(media);
        },
      ),
    );
  }

  Widget _showProgressIndicator() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _showError(Error error) {
    return Container(child: Center(child: Text("Something went wrong: ${error.stackTrace}"),),);
  }

  void _navigateToDetailsPage(Media media) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage.create(media: media)));
  }
}
