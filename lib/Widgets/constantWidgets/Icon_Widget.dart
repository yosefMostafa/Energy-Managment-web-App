import 'package:companywebapp/Widgets/Constants/ConstantColors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';




class Icon_Widget extends StatelessWidget {
  final IconData icon;
  final Function action;
  const Icon_Widget(this.icon,{Key? key, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(mobile: IconWidget(20,icon,action: action,),
      desktop: IconWidget(35,icon,action: action),tablet: IconWidget(25,icon,action: action),

    );
  }
}

class IconWidget extends StatelessWidget {
  final double size;
  final IconData icons;
  final Function action;
  const IconWidget(this.size,this.icons,{Key? key, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>action(),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: customBtengan,
          shape: BoxShape.circle
        ),
        padding: const EdgeInsets.all(5.0),
        child:  Icon(icons,size: size,color: Colors.white,),
      ),
    );
  }
}

