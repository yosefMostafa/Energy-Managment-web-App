import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:companywebapp/Blocks/bloc_exports.dart';
import 'package:meta/meta.dart';

import '../../Models/SEUmodel.dart';

part 'seus_event.dart';
part 'seus_state.dart';

class SeusBloc extends Bloc<SeusEvent, SeusState> {





  List<SEUmodel> sEUlist=[];
  final SEUmodelservice _service;
  SeusBloc(this._service) : super(SEUsLoadingState()) {
    on<SeusEvent>((event, emit) async{
      if(event is gettingallseuevent){
        List<SEUmodel> temp=await _service.getSEUsModel();
        if(temp.isNotEmpty){
          sEUlist=temp;
          emit(SEUlistchanged(sEUlist));
        }

      }
      if(event is Sortseuevent){
        List<SEUmodel> temp=sEUlist;
        temp.sort((a,b)=>event.compare(a,b));
        emit(SEUlistchanged(temp)) ;
      }
    if(event is AddSEU){
      sEUlist.add(event.item);
      Map data=event.item.toMap();
      data["source_id"]=1;
      data['target']= data['target'].toString();
      data['wpa']=data['wpa'].toString();
      await _service.putSEU(data);
      emit(SEUlistchanged(sEUlist));
    }else if (event is ADDSEUlist){

      for (var element in event.item) {
        sEUlist.add(element);
        Map data=element.toMap();
        data["source_id"]=1;
        data['target']= data['target'].toString();
        data['wpa']=data['wpa'].toString();
        await _service.putSEU(data);
      }
      emit(SEUlistchanged(sEUlist));
    }
    });
  }
}
