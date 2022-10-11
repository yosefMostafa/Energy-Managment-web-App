import 'package:companywebapp/Models/Generalmodel.dart';
import 'package:companywebapp/Models/MonthlyModel.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../Blocks/MonthlyReadings/monthly_readings_bloc.dart';
import '../Blocks/ProcessSEUDialog/process_seudialog_bloc.dart';
import '../Modules/excelload.dart';
import '../Widgets/Constants/ConsttextField.dart';
import '../Widgets/constantWidgets/BKG.dart';

import 'package:companywebapp/Widgets/constantWidgets/Type_select.dart';
import 'package:flutter/material.dart';

import '../Widgets/constantWidgets/CustomDialoge.dart';
import '../Widgets/constantWidgets/ThreeButtonDesign.dart';
import '../Widgets/constantWidgets/generateTable.dart';

class EnergyReadings extends StatelessWidget {
  MonthlyModel temp = MonthlyModel();
  double usageconverstionfactor=1;
  double costconverstionfactor=1;


  EnergyReadings({Key? key}) : super(key: key);

  showAddprocesDialoge(BuildContext context, Function save) {
    showDialog(
        useRootNavigator: false,
        context: context,
        builder: (BuildContext context) =>
            CustomDialoge(
              save: save,
              title: "Add New Reading",
              content: [
                {
                  'title': 'Month',
                  'widget': customDatePicker(context, () {
                    showMonthYearPicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(const Duration(days: 356*15)),
                      lastDate: DateTime.now().add(const Duration(days: 356)),
                    )
                        .then((value) =>
                    temp.month = value.toString().split(" ")[0])
                        .then((value) => print(temp.month));
                  }),
                },
                {
                  'title': 'usage/month kWh',
                  'widget': textFielddesign((String val) {
                    temp.usage = int.parse(val);
                  }),
                },
                {
                  'title': 'usage/month conversion factor',
                  'widget': textFielddesign((String val) {
                    usageconverstionfactor = double.parse(val);
                    print(usageconverstionfactor);
                  },keboardtype: TextInputType.number),
                },
                {
                  'title': 'Cost USD',
                  'widget': textFielddesign((String val) {
                    temp.cost = int.parse(val);
                  }, keboardtype: TextInputType.number),
                }
                ,
                {
                'title': 'Cost conversion factor to USD',
                'widget': textFielddesign((String val) {
                costconverstionfactor = double.parse(val);
                },keboardtype: TextInputType.number,
                )
                }
              ],
            ));
  }

  convertlistoftypes(List<GeneralTypes> types){
    List<String> output=[];
    types.forEach((element) { output.add(element.name);});
    return output;
  }
  _page(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        child: BlocBuilder<MonthlyReadingsBloc, MonthlyReadingsState>(
          builder: (context, state) {
           if(state is MonthlyReadingsLoadingState){
             return const Center(child: CircularProgressIndicator(),);
           }else{
             return Column(
               children: [
                 BlocBuilder<MonthlyReadingsBloc, MonthlyReadingsState>(
                   builder: (context, state) {
                     return ThreeButtoDesign(
                       actions: [
                             () {
                           showAddprocesDialoge(context, () {
                             temp.usage=(temp.usage*usageconverstionfactor).toInt();
                             temp.cost=(temp.cost*costconverstionfactor).toInt();
                             temp.type=BlocProvider
                                 .of<MonthlyReadingsBloc>(context)
                                 .type.id;
                             temp.toMap().forEach((key, value) {print(temp.toMap()["key"].runtimeType); });
                             BlocProvider.of<MonthlyReadingsBloc>(context)
                                 .add(AddMonthlyReading(temp.copyWith()));
                             temp = MonthlyModel();
                           });
                         },
                             () {},
                             () async {
                           try {
                             getExceldata("Month Energy").then((value)async {
                               if (value.isNotEmpty) {
                                 print(value["type"]);
                                 value["data"].forEach((el){
                                   el.type=BlocProvider
                                       .of<MonthlyReadingsBloc>(context)
                                       .types.singleWhere((element) => element.name==value["type"]).id;
                                 });
                                 // BlocProvider.of<MonthlyReadingsBloc>(context).add(Addtype(value["type"]));
                                 BlocProvider.of<MonthlyReadingsBloc>(context)
                                     .add(AddMonthlyReadingList(value["data"]));

                               }
                             });
                           } catch (e) {
                             print(e.toString());
                           }
                         }
                       ],
                     );
                   },
                 ),
                 const SizedBox(
                   height: 50,
                 ),
                 Align(
                   alignment: Alignment.bottomCenter,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       BlocBuilder<MonthlyReadingsBloc, MonthlyReadingsState>(
                         builder: (context, state) {
                           if (state is TypeState) {
                             return TypeSelect(
                               data: convertlistoftypes(BlocProvider
                                   .of<MonthlyReadingsBloc>(context)
                                   .types),
                               value: state.type.toLowerCase(), change: (value){
                               BlocProvider.of<MonthlyReadingsBloc>(context)
                                   .add(Addtype(value));
                             },
                             );
                           } else {
                             return TypeSelect(
                               data: convertlistoftypes(BlocProvider
                                   .of<MonthlyReadingsBloc>(context)
                                   .types),
                               value: BlocProvider
                                   .of<MonthlyReadingsBloc>(context)
                                   .type.name
                                   .toLowerCase(), change: (value){
                               BlocProvider.of<MonthlyReadingsBloc>(context)
                                   .add(Addtype(value));
                             },
                             );
                           }
                         },
                       ),
                       BlocBuilder<MonthlyReadingsBloc, MonthlyReadingsState>(
                         builder: (context, state) {
                           if (state is Monthlylistchanged) {
                             return GenerateTable(
                               (compare){
                                 BlocProvider.of<MonthlyReadingsBloc>(context).add(Sortevent(compare));
                               },
                               titles: const [{"title":'month','type':'date'}, {"title":'usage','type':'int','unit':'kWh'}, {"title":'cost','type':'int','unit':'USD'}],
                               data: state.monthlylist,
                             );
                           } else {
                             return GenerateTable(
                                   (compare){
                                 BlocProvider.of<MonthlyReadingsBloc>(context).add(Sortevent(compare));
                               },
                               titles: const [{"title":'month','type':'date'}, {"title":'usage','type':'int','unit':'kWh'}, {"title":'cost','type':'int','unit':'USD'}],
                               data: [],
                             );
                           }
                         },
                       ),
                     ],
                   ),
                 ),
                 const SizedBox(
                   height: 100,
                 ),
               ],
             );
           }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Build");
    return BKG(
      page: BlocProvider(
        create: (context) =>
        MonthlyReadingsBloc(
            RepositoryProvider.of<MonthlyReadingService>(context),RepositoryProvider.of<generalService>(context))..add(gettypes())..add(gettingalldataevent()),
        child: _page(context),
      ),
    );
  }
}
