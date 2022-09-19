
import 'package:companywebapp/Widgets/Constants/ConstantColors.dart';
import 'package:flutter/material.dart';


import 'PathItem.dart';

class NavbarItem extends StatelessWidget {
  final String title;
  final List<PathItem> childrenstabs;
  const NavbarItem(this.title,  {Key? key,this.childrenstabs=const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.all(20),
        title: Text(title),
        iconColor: Colors.black,
        textColor: Colors.black,
        backgroundColor: Colors.white,
        collapsedBackgroundColor: customGrey,
        children: childrenstabs,
      ),
    );
  }
}


