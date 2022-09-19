
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../Widgets/Constants/Constats.dart';
import 'Modelabstract.dart';
class MonthlyModel extends Modelabstract{

  String month;
  int usage;
  int unit;
  int cost;
  int type;









  MonthlyModel(
      {this.cost = 0,
        this.month = '00-00-0000',
        this.usage = 0,
        this.type=-1,
        this.unit = 1});

  MonthlyModel copyWith({
    String? month,
    int? usage,
    int? unit,
    int? cost,
    int? type,
  }) {
    return MonthlyModel(
      month: month ?? this.month,
      usage: usage ?? this.usage,
      unit: unit ?? this.unit,
      cost: cost ?? this.cost,
      type: type ?? this.type,
    );
  }
@override
  Map<String, dynamic> toMap() {
    return {
      'cost': this.cost,
      'month': this.month,
      'usage': this.usage,
      'unit_id': this.unit,

      'source_id': this.type,
    };
  }

  factory MonthlyModel.fromMap(Map<String, dynamic> map) {
    return MonthlyModel(
      month: map['month'] as String,
      usage: map['usage'] as int,
      // unit: map['unit']["name"] as String,
      cost: map['cost'] as int,
      type: map['source']["source_id"] as int,
    );
  }
}


class MonthlyReadingService{
  Future<List<MonthlyModel>> getMonthlyModel()async {
    try {
      final Dio dio=Dio();
      final response = await dio.get(
            "https://$API/get-all-monthly-energy-consumtion");


      if(response.statusCode==200) {
        final List<MonthlyModel> temp = [];

        response.data["data"].forEach((el) {
  print(el);
          temp.add(MonthlyModel.fromMap(el));
        });
        return temp;
      }
      return <MonthlyModel>[];
    }catch(e){
    print(e.toString());
    return <MonthlyModel>[];
    }
  }


  Future putMonthlyModel(Map dataupload)async {
    try {
      print( json.encode( dataupload));
      final response = await http.post(
        Uri.https(API,"/monthly-energy-consumtion",),body:jsonEncode( dataupload),
          headers: {
          "Content-Type":"application/json",
      });


      print(response.body);
    }catch(e){
      print(e.toString());
    }
  }
}