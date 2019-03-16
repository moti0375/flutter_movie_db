import 'package:flutter/material.dart';
import 'package:flutter_movie_db/data/service/base_service.dart';
class ServiceProvider extends InheritedWidget{

  ServiceProvider({Key key, Widget child, this.service}) : super(key: key, child: child);
  final BaseService service;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ServiceProvider of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(ServiceProvider) as ServiceProvider);
  }

}