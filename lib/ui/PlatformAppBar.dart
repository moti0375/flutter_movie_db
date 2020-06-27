import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart' show BuildContext;
import 'package:flutter_movie_db/ui/PlatformWidget.dart';

class PlatformAppBar extends PlatformWidget<CupertinoNavigationBar, AppBar> {

  PlatformAppBar({this.title});

  final Widget title;

  @override
  CupertinoNavigationBar buildCupertinoWidget(BuildContext context) {
    return CupertinoNavigationBar(
      middle: title,
    );
  }

  @override
  AppBar buildMaterialWidget(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: title,
    );
  }
}
