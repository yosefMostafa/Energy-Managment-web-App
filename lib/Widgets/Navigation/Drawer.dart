import 'package:companywebapp/Widgets/Constants/ConstantColors.dart';
import 'package:companywebapp/Widgets/Navigation/PathItem.dart';
import 'package:companywebapp/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../Navigation/NavItem.dart';

class CustomDrawer extends StatefulWidget {

  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  var _selected_page='';







  get_page()=>_selected_page;
  set_page(String value){
    setState(() {
      _selected_page=value;
    });
  }
  @override
  Widget build(BuildContext context) {








    return ResponsiveBuilder(
     builder: (BuildContext context, SizingInformation sizingInformation){
       return Container(
           color: customBtengan,
           width: sizingInformation.isTablet?150:300,
           child: Stack(
             children: [
               HomeLogo(set_page: set_page,
                   get_page: get_page),
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children:  [
                   NavbarItem(
                     "Data Entry",
                     childrenstabs:  [
                       PathItem(ENERGYREADINGS, const Text(ENERGYREADINGS), set_page: set_page,
                           get_page: get_page),
                       PathItem(SEUPAGE, const Text(SEUPAGE), set_page: set_page,
                           get_page: get_page),
                       PathItem(PROCESSPAGE, const Text(PROCESSPAGE), set_page: set_page,
                           get_page: get_page),
                       PathItem(SENSORREF, const Text(SENSORREF), set_page: set_page,
                           get_page: get_page),
                     ],

                   ),
                   const SizedBox(
                     height: 5,
                   ),
                    NavbarItem("Outputs", childrenstabs:  [
                     PathItem(GRAPHS, const Text(GRAPHS), set_page: set_page,
                         get_page: get_page),
                      PathItem(REPORTS, const Text(REPORTS), set_page: set_page,
                          get_page: get_page),

                   ],),
                 ],
               ),
             ],
           ));
     },
    );
  }
}

class HomeLogo extends StatelessWidget {
  const HomeLogo({Key? key, required this.set_page, required this.get_page}) : super(key: key);
  final Function set_page,get_page;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: PathItem(
        HOME,
        Container(
          color: customGrey,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: const [
              Icon(
                Icons.home,
                color: Colors.black,
              ),
              Text("Home"),
            ],
          ),
        ),
          set_page: set_page,
          get_page: get_page
      ),
    );
  }
}
