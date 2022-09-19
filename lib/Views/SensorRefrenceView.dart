import 'package:flutter/material.dart';


import '../Widgets/constantWidgets/BKG.dart';



class SensoreRefrenceView extends StatelessWidget {
  const SensoreRefrenceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BKG(
      page:Container(
        color: Colors.amber,
        child: const Text("Connect Sensor"),
      ),);
  }
}
