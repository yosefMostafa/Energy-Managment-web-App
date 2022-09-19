part of 'process_seu_bloc.dart';

@immutable
abstract class ProcessSeuState {}

class ProcessSeuInitial extends ProcessSeuState {}

class GroupState extends ProcessSeuState{
  final String group;

  GroupState(this.group);
}

class ProcessListState extends ProcessSeuState{

  final List<ProcessSEUmodel> processlist;
  ProcessListState(this.processlist);
}
class LightListState extends ProcessSeuState{

  final List<LightinigModel> Lightlist;
  LightListState(this.Lightlist);
}
class SEULoadingState extends ProcessSeuState {}


class SEULoadedState extends ProcessSeuState{
  final String activity;
  SEULoadedState(this.activity);
}

