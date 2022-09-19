part of 'seus_bloc.dart';

@immutable
abstract class SeusState {}

class SeusInitial extends SeusState {}
class SEUlistchanged extends SeusState{





  final List<SEUmodel> sEUlist;
  SEUlistchanged(this.sEUlist);
}
class SEUsLoadingState extends SeusState {}


class SEUsLoadedstate extends SeusState{
  final String activity;
  SEUsLoadedstate(this.activity);
}
