import 'package:dio/dio.dart';

import '../Widgets/Constants/Constats.dart';

class GeneralTypes {
 int id;
 String name;

 GeneralTypes({
    required this.id,
    required this.name,
  });

 Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

  factory GeneralTypes.fromMap(Map<String, dynamic> map) {
   print(map);
    return GeneralTypes(
      id: map['source_id'] as int,
      name: map['name'] as String,
    );
  }

 GeneralTypes copyWith({
    int? id,
    String? name,
  }) {
    return GeneralTypes(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
class generalService{
  Future<List<GeneralTypes>> gettypes() async{
    try {
      final Dio dio=Dio();
      final response = await dio.get(
          "https://$API/get-energy-sources");


      if(response.statusCode==200) {
        final List<GeneralTypes> temp = [];
        print(response.data["data"]);
        response.data["data"].forEach((el) {

          temp.add(GeneralTypes.fromMap(el));
        });
        return temp;
      }
      return <GeneralTypes>[];
    }catch(e){
      print(e.toString());
      return <GeneralTypes>[];
    }
  }


}