import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'Drawer.dart';
import 'Navbar.dart';



class NavigationView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _globalkey = GlobalKey<ScaffoldState>();
  NavigationView({Key? key}) : super(key: key);
  openDrawerFunction(){
    _globalkey.currentState?.openDrawer();
  }
  closeDrawerFunction(){
    _globalkey.currentState?.closeDrawer();

  }
  @override
  Widget build(BuildContext context) {

    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation)
      {
        return Scaffold(
          key: _globalkey,
          drawer: sizingInformation.isMobile?const CustomDrawer():null,
          body: Navbar(openDrawerFunction),
        );
        },

    );
  }
}

