import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_db/data/model/media_category.dart';
import 'package:flutter_movie_db/data/repository/base_service.dart';
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
      builder: (c, repo, __) => BlocProvider<MorePageBloc>(
        create: (c) => MorePageBloc(repo, category),
        child: Consumer<MorePageBloc>(
          builder: (_, bloc, __) => MorePage(
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
    widget.bloc.add(LoadMoreEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformAppBar(
        title: Text("More"),
      ).build(context),
      body: BlocBuilder<MorePageBloc, MorePageState>(builder: (context, state) {
        print("builder: ${state.toString()}");
        if (state is LoadingMore) {
          return _showProgressIndicator();
        }

        if (state is MediaLoaded) {
          return _buildContent(state);
        }

        return SizedBox.shrink();
      }),
    );
  }

  Widget _buildContent(MediaLoaded state) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: MediaGridLayout(
        items: state.items,
        onItemClick: (media) {},
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
}
