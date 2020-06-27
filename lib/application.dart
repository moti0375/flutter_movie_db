import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_db/data/repository/base_service.dart';
import 'package:flutter_movie_db/data/repository/tmdb_repository.dart';
import 'package:flutter_movie_db/pages/home_page/home_page.dart';
import 'package:provider/provider.dart';



class MvdbApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BaseRepository service = TmdbRepository();

    return Provider<BaseRepository>(
      create: (c) => service,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.white),
        home: HomePage.create(context),
      ),
    );
  }
}
