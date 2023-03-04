import 'package:flutter/material.dart';
import 'package:flutter_movie_db/application.dart';
import 'package:flutter_movie_db/di/locator.dart';

void main() async {
  await setupLocator();
  runApp(MvdbApp());
}