




import 'package:dio/dio.dart';

import '../Widgets/Constants/Constats.dart';

class ProcessSEUmodel {




  String month;
  String purpose;
  String SEU;
  String hpmonth;
  String name;
  String VSD;
  String nameplateload;
  String note;
  String switched_off_times;
  String estimates;
  String improvement;
  String usage;
  String unit;

  ProcessSEUmodel(
      {this.month = '00-00-000',
        this.usage = '00',
        this.hpmonth = '00',
        this.SEU = 'none',
        this.name='None',
        this.switched_off_times='None',
        this.nameplateload='0',
        this.estimates='None',
        this.improvement='None',
        this.note='None',
        this.VSD='0',
        this.purpose = 'none',
        this.unit = 'kwh'});

  ProcessSEUmodel copyWith({
    String? month,
    String? purpose,
    String? SEU,
    String? hpmonth,
    String? name,
    String? VSD,
    String? nameplateload,
    String? note,
    String? switched_off_times,
    String? estimates,
    String? improvement,
    String? usage,
    String? unit,
  }) {
    return ProcessSEUmodel(
      month: month ?? this.month,
      purpose: purpose ?? this.purpose,
      SEU: SEU ?? this.SEU,
      hpmonth: hpmonth ?? this.hpmonth,
      name: name ?? this.name,
      VSD: VSD ?? this.VSD,
      nameplateload: nameplateload ?? this.nameplateload,
      note: note ?? this.note,
      switched_off_times: switched_off_times ?? this.switched_off_times,
      estimates: estimates ?? this.estimates,
      improvement: improvement ?? this.improvement,
      usage: usage ?? this.usage,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'month': this.month,
      'purpose': this.purpose,
      'SEU': this.SEU,
      'hpmonth': this.hpmonth,
      'name': this.name,
      'VSD': this.VSD,
      'nameplateload': this.nameplateload,
      'note': this.note,
      'switched_off_times': this.switched_off_times,
      'estimates': this.estimates,
      'improvement': this.improvement,
      'usage': this.usage,
      'unit': this.unit,
    };
  }

  factory ProcessSEUmodel.fromMap(Map<String, dynamic> map) {
    return ProcessSEUmodel(
      month: map['month'] as String,
      purpose: map['purpose'] as String,
      SEU: map['SEU'] as String,
      hpmonth: map['hpmonth'] as String,
      name: map['name'] as String,
      VSD: map['VSD'] as String,
      nameplateload: map['nameplateload'] as String,
      note: map['note'] as String,
      switched_off_times: map['switched_off_times'] as String,
      estimates: map['estimates'] as String,
      improvement: map['improvement'] as String,
      usage: map['usage'] as String,
      unit: map['unit'] as String,
    );
  }
}

class ProcessSEUservice
{
Future<List<ProcessSEUmodel>> getSEUsProcessModels()async {
  try {
    final Dio dio=Dio();
    final response = await dio.get(
        "https://$API/get-all-heat-users");


    if(response.statusCode==200) {
      final List<ProcessSEUmodel> temp = [];

      response.data["data"].forEach((el) {
        print(el);
        temp.add(ProcessSEUmodel.fromMap(el));
      });
      return temp;
    }
    return <ProcessSEUmodel>[];
  }catch(e){
    print(e.toString());
    return <ProcessSEUmodel>[];
  }
}


}
