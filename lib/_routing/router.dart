import 'package:flutter/material.dart';
import 'package:flutter_app/_routing/routes.dart';
import 'package:flutter_app/pages/Register.dart';
import 'package:flutter_app/pages/TabBarAnimation.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case registerViewRoute:
      return MaterialPageRoute(builder: (context) => RegisterPage());
      break;
    default:
      return MaterialPageRoute(builder: (context) => TabBarAnimation());
  }
}