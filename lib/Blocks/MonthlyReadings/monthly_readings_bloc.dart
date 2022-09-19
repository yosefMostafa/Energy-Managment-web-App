import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:companywebapp/Blocks/bloc_exports.dart';
import 'package:meta/meta.dart';

import '../../Models/Generalmodel.dart';
import '../../Models/MonthlyModel.dart';

part 'monthly_readings_event.dart';
part 'monthly_readings_state.dart';

class MonthlyReadingsBloc extends Bloc<MonthlyReadingsEvent, MonthlyReadingsState> {



final MonthlyReadingService _service;
final generalService _typtservice;
List<GeneralTypes> types=[];
GeneralTypes type=GeneralTypes(id: -1,name: '');
  List<MonthlyModel> Monthlylist=[];
  MonthlyReadingsBloc(this._service, this._typtservice) : super(MonthlyReadingsLoadingState()) {
    on<MonthlyReadingsEvent>((event, emit)async {
      if(event is Sortevent){
       List<MonthlyModel> temp=Monthlylist.where((element) => element.type==type.id).toList();
       temp.sort((a,b)=>event.compare(a,b));
      emit(Monthlylistchanged(temp)) ;
      }
      if(event is AddMonthlyReading){

        Monthlylist=[...Monthlylist,event.item];
        await _service.putMonthlyModel(event.item.toMap());
        emit(Monthlylistchanged(Monthlylist.where((element) => element.type==type.id).toList()));
      }else if (event is AddMonthlyReadingList){
        event.item.forEach((element) async{
          Monthlylist.add(element);
          await _service.putMonthlyModel(element.toMap());
        });
        emit(Monthlylistchanged(Monthlylist.where((element) => element.type==type.id).toList()));
      }else if(event is Addtype){
        List<GeneralTypes> temp=types.where((element) => element.name==event.item).toList();
        type=temp[0].copyWith();
        emit(TypeState(type.name));
        emit(Monthlylistchanged(Monthlylist.where((element) => element.type==type.id).toList()));
      }else if (event is gettingalldataevent){
        final data=await _service.getMonthlyModel();
        print(data);
        Monthlylist.addAll(data);

        emit(TypeState(type.name));
        emit(Monthlylistchanged(Monthlylist.where((element) => element.type==type.id).toList()));

      }
      else if (event is gettypes){
        final data=await _typtservice.gettypes();

        types.addAll(data);
        if(types.isNotEmpty){
          type=types[0].copyWith();
        }

      }
    });
  }
}