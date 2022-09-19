import 'package:flutter/material.dart';

import '../Constants/ConstantColors.dart';


class BKG extends StatelessWidget {
  final Widget? page;
  const BKG({Key? key,this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration:  BoxDecoration(
color:customBtengan.withOpacity(0.5),
            // image: DecorationImage(
            //
            //   image: AssetImage('images/electric.png'),
            //   filterQuality: FilterQuality.high,
            //   fit: BoxFit.fill
            //
            // )
          ),
        ),
        Container(
          
          margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffe6e6e6),
          ),
         
         
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 50,vertical: 50),
          child:page ,),
      ],
    );
  }
}
