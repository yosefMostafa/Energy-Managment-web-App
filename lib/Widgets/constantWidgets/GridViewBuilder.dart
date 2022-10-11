import 'package:flutter/material.dart';

import '../Constants/ConstantColors.dart';
import 'CustomBuilder.dart';
import 'MonthlyGraphsCard.dart';
import 'MonthlyGraphsCardReport.dart';

class GridViewBuilder extends StatelessWidget {
  final List data;
  final int cross_count;
  final String type;
  final String optional1;
  const GridViewBuilder(this.data,this.cross_count,{Key? key,  this.type='',this.optional1=''}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GridView.builder(


      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: MediaQuery.of(context).size.height/2,
          crossAxisCount: data.length>cross_count?cross_count:data.length

    ),
      itemCount: data.length,
      itemBuilder: (context, index) => Selection(type,data[index],optional1),);
  }
}
class ListViewBuilder extends StatelessWidget {
  final List data;
  final String type;
  final String optional1;
  const ListViewBuilder(this.data, {Key? key,  this.type='',this.optional1=''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) => Selection(type,data[index],optional1),
      itemCount: data.length,
    );
  }
}

Selection(String type,dynamic data,String option){
  switch(type){
    case 'Monthly Readings':
      return MonthlyGraphsCard(data);
    case 'Monthly Readings Report':
      return MonthlyGraphsCardReport(data,option);
    case 'SEUs':
      return data;
    default:
      return  CustomBuilder(data);
  }
}

