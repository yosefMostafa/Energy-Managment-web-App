part of 'monthly_readings_bloc.dart';

@immutable
abstract class MonthlyReadingsState {}

class MonthlyReadingsLoadingState extends MonthlyReadingsState {}






class MonthlyReadingsLoadedstate extends MonthlyReadingsState{
  final String activity;
  MonthlyReadingsLoadedstate(this.activity);
}


class Monthlylistchanged extends MonthlyReadingsState{




  final List<MonthlyModel> monthlylist;
  Monthlylistchanged(this.monthlylist);
}
class TypeState extends MonthlyReadingsState{

  final String type;
  TypeState(this.type);
}