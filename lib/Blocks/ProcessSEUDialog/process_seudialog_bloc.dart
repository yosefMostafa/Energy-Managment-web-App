import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:companywebapp/Blocks/bloc_exports.dart';
import 'package:meta/meta.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/ProcessSEUmodel.dart';

part 'process_seudialog_event.dart';
part 'process_seudialog_state.dart';

class ProcessSeudialogBloc extends Bloc<ProcessSeudialogEvent, ProcessSeudialogState> {


  ProcessSEUmodel model=ProcessSEUmodel();
  ProcessSeudialogBloc() : super(ProcessSeudialogInitial()) {
    on<ProcessSeudialogEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
