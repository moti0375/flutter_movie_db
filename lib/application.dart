import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_movie_db/data/model/movie.dart';
import 'package:flutter_movie_db/data/service/ServiceProvider.dart';
import 'package:flutter_movie_db/data/service/base_service.dart';
import 'package:flutter_movie_db/data/service/tmdb_service.dart';
import 'package:flutter_movie_db/network/base_http_client.dart';
import 'package:flutter_movie_db/pages/home_page/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';



class MvdbApp extends StatelessWidget {

  @override
  StatelessElement createElement() {
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    print("build: ${ServiceProvider.of(context)}");
    BaseService service = TmdbService();

    return ServiceProvider(
      service: service,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.white),
        home: ScopedModel<MoviesModel>(
          model: MoviesModel(stream: service.getNowPlaying()),
          child: HomePage(),
        ),
      ),
    );
  }
}
