part of 'seus_bloc.dart';

@immutable
abstract class SeusEvent {}









class gettingallseuevent extends SeusEvent{
  gettingallseuevent();
  @override
  List<Object> get props => [];
}



class ADDSEUlist extends SeusEvent{
  final List<SEUmodel> item;
  ADDSEUlist(this.item);
  @override
  List<Object> get props => [item];
}

class Sortseuevent extends SeusEvent{
  final Function compare;
  Sortseuevent(this.compare);
  @override
  List<Object> get props => [compare];
}
class AddSEU extends SeusEvent{
  final SEUmodel item;
  AddSEU(this.item);

  @override
  List<Object> get props => [item];
}