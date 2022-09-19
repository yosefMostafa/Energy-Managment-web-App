import 'package:flutter/material.dart';


import 'ConstantColors.dart';

textFielddesign(Function onchange,{TextInputType keboardtype=TextInputType.text}){
  return TextField(
    keyboardType: keboardtype,
    onChanged: (val)=>onchange(val),
    decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: InputBorder.none),
  );
}customDatePicker(BuildContext context,Function onPressed){
  return  TextField(
    readOnly: true,

    // enabled: false,
    decoration:  InputDecoration(
        suffixIcon: IconButton(onPressed: () async =>onPressed()

            , icon: const Icon(Icons.date_range,color: customSelection,)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: InputBorder.none),
  );
}
