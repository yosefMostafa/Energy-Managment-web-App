import 'package:flutter/material.dart';

import '../Constants/ConstantColors.dart';




class TypeSelect extends StatelessWidget {
  final List data;
  final String value;
  final Function change;
  final Color iconColor;
  const TypeSelect({Key? key, required this.data,required this.value,required this.change,this.iconColor=Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: customBtengan.withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton<String>(
        elevation: 0,
        icon: Icon( Icons.keyboard_arrow_down,color: iconColor,),
        underline: const SizedBox(width:
        0,),
        iconSize: 15,
        value: value,
        items: data.map((e) => DropdownMenuItem<String>(

          value: e,child: Text(e,),)).toList(),
        onChanged: (value)=>change(value),
      ),
    );
  }
}
