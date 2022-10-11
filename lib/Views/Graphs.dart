import 'package:companywebapp/Widgets/constantWidgets/GridViewBuilder.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../Widgets/constantWidgets/BKG.dart';
import 'MonthlyGraphs.dart';
import 'SEUsGraphs.dart';

class GraphsGrid extends StatelessWidget {
  GraphsGrid({Key? key}) : super(key: key);

  List<Map> data = [
    {
      "title": "Monthly Readings Graph",
      'description':
          "Shows A detailed Graph about latest Monthly Records available",
      'page': const MonthlyGraphs(),
      "icon": const Icon(
        Icons.auto_graph,
        size: 60,
        color: Colors.white,
      ),
    },
    {
      "title": "SEUs Process Graph",
      'description': "Shows A Bar Graph about SEU Records available",
      'page': const SEUSGraphs(),
      "icon": const Icon(
        Icons.bar_chart,
        size: 60,
        color: Colors.white,
      ),
    },
    {
      "title": "Processes",
      'description': "Shows A  Graph about Processes Records available",
      'page': const MonthlyGraphs(),
      "icon": const Icon(
        Icons.area_chart,
        size: 60,
        color: Colors.white,
      ),
    },
    {
      "title": "Lightinig",
      'description': "Shows A  Graph about Lightinig Records available",
      'page': const MonthlyGraphs(),
      "icon": const Icon(
        Icons.graphic_eq,
        size: 60,
        color: Colors.white,
      ),
    }
  ];

  _page(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ScreenTypeLayout(
          mobile: ListViewBuilder(data),
          tablet: GridViewBuilder(data, 2),
          desktop: GridViewBuilder(data, 3),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: _page(context),
        desktop: BKG(
          page: _page(context),
        ),
        tablet: BKG(
          page: _page(context),
        ));
  }
}
