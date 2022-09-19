import 'dart:async';
import 'package:flutter/material.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Models/LightinigModel.dart';
import '../../Models/ProcessSEUmodel.dart';

part 'process_seu_event.dart';
part 'process_seu_state.dart';

class ProcessSeuBloc extends Bloc<ProcessSeuEvent, ProcessSeuState> {
String group='SEU';
List<ProcessSEUmodel> SEUprocesslist=[];
List<LightinigModel> SEULightiniglist=[];
final ProcessSEUservice _processService;
final LightinigService _lightService;



  ProcessSeuBloc(this._processService, this._lightService) : super(SEULoadingState()) {
    on<ProcessSeuEvent>((event, emit) {
      if(event is SEULoadingState ){
        switch(group){
          case 'SEU':

          default:

        }
      }
     if(event is GroupEvent){
       emit(GroupState(event.group));
     }else if(event is Addprocess){
       SEUprocesslist.add(event.item);
       emit(ProcessListState(SEUprocesslist));
     }else if(event is AddLight){
       SEULightiniglist.add(event.item);
       emit(LightListState(SEULightiniglist));
     }else if (event is AddprocessList){
       for (var element in event.item) {SEUprocesslist.add(element);}
       emit(ProcessListState(SEUprocesslist));
     }
     else if (event is AddLightList){
       for (var element in event.item) {SEULightiniglist.add(element);}
       emit(LightListState(SEULightiniglist));
     }
    });
  }
}
