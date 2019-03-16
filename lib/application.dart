import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_movie_db/data/service/ServiceProvider.dart';
import 'package:flutter_movie_db/data/service/base_service.dart';
import 'package:flutter_movie_db/data/service/tmdb_service.dart';
import 'package:flutter_movie_db/network/base_http_client.dart';
import 'package:flutter_movie_db/pages/home_page/home_page.dart';
import 'package:flutter/cupertino.dart';



class MvdbApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ServiceProvider(
      service: TmdbService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.white),
        home: HomePage(),
      ),
    );
  }
}
