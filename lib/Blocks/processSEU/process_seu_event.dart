part of 'process_seu_bloc.dart';

@immutable
abstract class ProcessSeuEvent {


}
class GroupEvent extends ProcessSeuEvent{
  final String group;

   GroupEvent(this.group);

  @override
  List<Object> get props => [group];
}

class gettingallProcessesevent extends ProcessSeuEvent{
  gettingallProcessesevent();
  @override
  List<Object> get props => [];
}
class gettingallLightevent extends ProcessSeuEvent{
  gettingallLightevent();
  @override
  List<Object> get props => [];
}

class Addprocess extends ProcessSeuEvent{

  final ProcessSEUmodel item;

  Addprocess(this.item);

  @override
  List<Object> get props => [item];
}
class AddprocessList extends ProcessSeuEvent{

  final List<ProcessSEUmodel> item;

  AddprocessList(this.item);

  @override
  List<Object> get props => [item];
}

class AddLight extends ProcessSeuEvent{

  final LightinigModel item;

  AddLight(this.item);

  @override
  List<Object> get props => [item];
}class AddLightList extends ProcessSeuEvent{

  final List<LightinigModel> item;

  AddLightList(this.item);

  @override
  List<Object> get props => [item];
}
