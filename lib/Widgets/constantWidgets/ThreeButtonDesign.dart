import 'package:companywebapp/Widgets/Constants/ConstantColors.dart';
import 'package:flutter/material.dart';

import 'Icon_Widget.dart';




class ThreeButtoDesign extends StatelessWidget {
  final int exception;
  final List<Function> actions;
  final Widget? extraheaders;
  const ThreeButtoDesign({Key? key,this.exception=-1, required this.actions,this.extraheaders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
    decoration: BoxDecoration(
      color: customSelection,
      borderRadius: BorderRadius.circular(10),
    ),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         SizedBox(
           child: extraheaders,
         ),
            Row(

            children:  [
              exception==0?const SizedBox(): Icon_Widget(Icons.add,action: actions[0],),
              exception==0?const SizedBox():const SizedBox(width: 10),
              exception==1?const SizedBox(): Icon_Widget(Icons.link,action:actions[1]),
              exception==1?const SizedBox():const SizedBox(width: 10),
              exception==2?const SizedBox():Icon_Widget(Icons.upload,action:actions[2]),
            ],
          ),
        ],
      ),
    );
  }
}
