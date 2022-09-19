import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../Widgets/Constants/Constats.dart';
import 'Modelabstract.dart';

class SEUmodel extends Modelabstract{

  String name;
  String driver;
  String meter_type;
  double wpa;
  String influencer;
  String objective;
  double targetkwh;
  String ENPI;









  SEUmodel({this.name='None', this.driver='None', this.meter_type='None', this.wpa=0, this.influencer='None',
      this.objective='None', this.targetkwh=0, this.ENPI='0'});
@override
  Map<String, dynamic> toMap() {
    return {
      'type': this.name,
      'main_driver': this.driver,
      'meter_type': this.meter_type,
      'wpa': this.wpa,
      'influencer': this.influencer,
      'objective': this.objective,
      'target': this.targetkwh,
      // 'ENPI': this.ENPI,
    };
  }

  factory SEUmodel.fromMap(Map<String, dynamic> map) {
    return SEUmodel(
      name: map['type'] as String,
      driver: map['main_driver'] as String,
      meter_type: map['meter_type'] as String,
      wpa: double.parse(map['wpa']) ,
      influencer: map['influencer'] as String,
      objective: map['objective'] as String,
      targetkwh: double.parse(map['target']) ,
      // ENPI: map['ENPI'] as String,
    );
  }

  SEUmodel copyWith({
    String? name,
    String? driver,
    String? meter_type,
    double? wpa,
    String? influencer,
    String? objective,
    double? targetkwh,
    String? ENPI,
  }) {
    return SEUmodel(
      name: name ?? this.name,
      driver: driver ?? this.driver,
      meter_type: meter_type ?? this.meter_type,
      wpa: wpa ?? this.wpa,
      influencer: influencer ?? this.influencer,
      objective: objective ?? this.objective,
      targetkwh: targetkwh ?? this.targetkwh,
      ENPI: ENPI ?? this.ENPI,
    );
  }
}

class SEUmodelservice {
  Future<List<SEUmodel>> getSEUsModel()async {
    try {
      final Dio dio=Dio();
      final response = await dio.get(
          "https://$API/get-all-energy-seu");


      if(response.statusCode==200) {
        final List<SEUmodel> temp = [];

        response.data["data"].forEach((el) {
          print(el);
          temp.add(SEUmodel.fromMap(el));
        });
        return temp;
      }
      return <SEUmodel>[];
    }catch(e){
      print(e.toString());
      return <SEUmodel>[];
    }
  }
  Future putSEU(Map dataupload)async {
    try {
      print( json.encode( dataupload));
      final response = await http.post(
          Uri.https(API,"/energy-seu",),body:jsonEncode( dataupload),
          headers: {
            "Content-Type":"application/json",
          });


      print(response.body);
    }catch(e){
      print(e.toString());
    }
  }
}