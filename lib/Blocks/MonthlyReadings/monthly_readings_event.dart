part of 'monthly_readings_bloc.dart';

@immutable
abstract class MonthlyReadingsEvent {}

class AddMonthlyReading extends MonthlyReadingsEvent{
  final MonthlyModel item;
  AddMonthlyReading(this.item);
  @override
  List<Object> get props => [item];
}
class gettingalldataevent extends MonthlyReadingsEvent{
  gettingalldataevent();
  @override
  List<Object> get props => [];
}
class AddMonthlyReadingList extends MonthlyReadingsEvent{
  final List<MonthlyModel> item;
  AddMonthlyReadingList(this.item);
  @override
  List<Object> get props => [item];
}

class Addtype extends MonthlyReadingsEvent{
  final String item;
  Addtype(this.item);
  @override
  List<Object> get props => [item];
}
class gettypes extends MonthlyReadingsEvent{
  gettypes();
  @override
  List<Object> get props => [];
}
class Sortevent extends MonthlyReadingsEvent{
  final Function compare;
  Sortevent(this.compare);
  @override
  List<Object> get props => [compare];
}