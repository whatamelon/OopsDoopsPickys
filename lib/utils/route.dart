import 'package:explore/screens/register_page.dart';
import 'package:fluro/fluro.dart' as p;
import 'package:flutter/material.dart';

import '../screens/home_page.dart';

class FluroRouter {
  static p.Router router = p.Router();
//  static Handler _storyhandler = Handler(
//      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
//          HomeView(id: params['id'][0]));
  static p.Handler _homehandler = p.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          HomePage());
  static p.Handler _registerHandler = p.Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          RegisterPage());
  static p.TransitionType fadeIn = p.TransitionType.fadeIn;
  static void setupRouter() {
    router.define(
      '/',
      handler: _homehandler,
    );
//    router.define(
//      '/story/:id',
//      handler: _storyhandler,
//    );
    router.define(
      '/register',
      handler: _registerHandler,
    );
  }
}