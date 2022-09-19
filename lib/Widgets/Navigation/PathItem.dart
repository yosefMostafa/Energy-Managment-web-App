import 'package:companywebapp/Widgets/Constants/ConstantColors.dart';
import 'package:companywebapp/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../locator.dart';
import '../../services/Navigationservice.dart';

class PathItem extends StatelessWidget {
  final String  navpath;
  final Widget title;
  final Function set_page,get_page;
  const PathItem(this.navpath, this.title, {Key? key, required this.set_page, required this.get_page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        return GestureDetector(
          onTap: () {
            set_page(navpath);
            locator<Navigationservice>().navigateTo(navpath);
            if (sizingInformation.isMobile) {
              Navigator.pop(context);
            }

          },
          child:  Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: get_page()==navpath?get_page()==HOME?Colors.transparent:customSelection:Colors.transparent,
              borderRadius: BorderRadius.circular(5.0),
            ),
            width: double.infinity,


            child: title,
          ),

        );
      },
    );
  }
}