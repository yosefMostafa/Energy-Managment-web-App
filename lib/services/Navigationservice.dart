import 'package:flutter/material.dart';

class Navigationservice{
  final GlobalKey<NavigatorState> navigatorkey=GlobalKey<NavigatorState>();

 navigateTo(String route){
    return navigatorkey.currentState?.pushNamed(route);
  }
  goBack(){
     navigatorkey.currentState?.pop();
  }
}