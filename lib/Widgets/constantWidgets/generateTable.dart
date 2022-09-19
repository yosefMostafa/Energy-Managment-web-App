import 'package:companywebapp/Models/MonthlyModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';


import '../../Models/Modelabstract.dart';
import '../../Modules/Convertions.dart';
import '../Constants/ConstantColors.dart';

class GenerateTable extends StatelessWidget {
  final List<Map> titles;
  final List data;
  final Function addsort;
   GenerateTable(this.addsort,{Key? key, required this.titles, required this.data})
      : super(key: key);

  genrateHeaders() {
    return TableRow(
      decoration:   BoxDecoration(
        borderRadius: data.isNotEmpty? const BorderRadius.only(topLeft:Radius.circular(10),topRight: Radius.circular(10)):BorderRadius.circular(10),
        color: customSelection,
      ),
      children: titles
          .map(
            (e) => Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: ResponsiveBuilder(builder: (context,si){
                if(si.isMobile||si.isTablet){
                  return  Column(
                    children: [
                      Center(child: Text(e['title'][0].toUpperCase()+e['title'].toString().substring(1,e["title"].length)+

                          (e.containsKey("unit")?"/${e['unit']}":""))),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child:Iconsort(e,addsort),
                      ),

                    ],);
                }else{
                  return  Stack(
                    children: [
                      Center(child: Text(e['title'][0].toUpperCase()+e['title'].toString().substring(1,e["title"].length)+

                          (e.containsKey("unit")?"/${e['unit']}":""))),
                      Align(
                        alignment: Alignment.centerRight,
                        child:Iconsort(e,addsort),
                      ),

                    ],);
                }

              },)

            ),
          )
          .toList(),
    );
  }

  TableRow generatedatarows(dynamic value) {
    Map data=value.toMap();

    return TableRow(
      children: titles
          .map(
            (e) {
              String date='';

              if(e['title']=='month'){

                List<String> tempdata=data[e['title']].toString().split("-");
                try {
                  date = DateFormat.yMMMM().format(DateTime(
                      int.parse(tempdata[0]), int.parse(tempdata[1]),
                      int.parse(tempdata[2])));
                }catch(e){
                  date='';
                }
              }
              String value=e['title']=='month'?date:data[e['title']].toString();
              return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(value,style:const  TextStyle(color: Colors.black),),
            );
            },
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
print(data);
    return Table(

        border: TableBorder.all(
          borderRadius: const BorderRadius.horizontal(left:Radius.circular(10),right: Radius.circular(10)),
            color: customBtengan, style: BorderStyle.solid, width: 1),
        children: [
          ...[genrateHeaders()],
          ...data.map<TableRow>((e) => generatedatarows(e)).toList(),
        ]);
  }
}

class Iconsort extends StatefulWidget {
  final Map title;
  final Function addsort;
  const Iconsort(this.title,this.addsort,{Key? key}) : super(key: key);

  @override
  State<Iconsort> createState() => _IconsortState();
}

class _IconsortState extends State<Iconsort> {

  bool state=true;
  sort(){
    if(state){

      if(widget.title['type']=='int') {
        return (Modelabstract a, Modelabstract b) {
              final  tempa=a.toMap();
              final  tempb=b.toMap();
              return compardescending(tempa[widget.title['title']],tempb[widget.title['title']]);
            };
      }else if (widget.title['type']=='string'){
        return (Modelabstract a, Modelabstract b) {
              final  tempa=a.toMap();
              final  tempb=b.toMap();
              return tempa[widget.title['title']].toString().compareTo(tempb[widget.title['title']]);
            };
      }else{
        return (Modelabstract a, Modelabstract b) {
              final  tempa=a.toMap();
              final  tempb=b.toMap();
              return toDateTime(tempa[widget.title['title']]).compareTo(toDateTime(tempb[widget.title['title']]));
            };
      }
    }else{
      if(widget.title['type']=='int') {
        return (Modelabstract a,Modelabstract b) {
              final tempa=a.toMap();
              final tempb=b.toMap();

              return comparescending(tempa[widget.title['title']],tempb[widget.title['title']]);
            };
      }else if (widget.title['type']=='string'){
        return (Modelabstract a, Modelabstract b) {
              final  tempa=a.toMap();
              final  tempb=b.toMap();
              return tempb[widget.title['title']].toString().compareTo(tempa[widget.title['title']]);
            };
      }else{
      return (Modelabstract a, Modelabstract b) {
              final  tempa=a.toMap();
              final  tempb=b.toMap();
              return toDateTime(tempb[widget.title['title']]).compareTo(toDateTime(tempa[widget.title['title']]));
            };
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    print("Iconsort");
    return GestureDetector(
        onTap: (){
          setState(() {
            state=!state;
          });
         widget.addsort( sort());
        },
        child:  Icon(state?Icons.arrow_drop_down_rounded:Icons.arrow_drop_up_rounded));
  }
}
