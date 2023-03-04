import 'dart:io';

import 'package:flutter/material.dart';

abstract class PlatformWidget<C extends Widget, M extends Widget> extends StatelessWidget{
  PlatformWidget({Key? key}) : super(key: key);

  PreferredSizeWidget buildCupertinoWidget(BuildContext context);
  PreferredSizeWidget buildMaterialWidget(BuildContext context);

  @override
  PreferredSizeWidget build(BuildContext context) {
    if(Platform.isIOS){
      return buildCupertinoWidget(context);
    }
    return buildMaterialWidget(context);
  }

}