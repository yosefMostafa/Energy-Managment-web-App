import 'package:companywebapp/Views/MonthlyGraphs.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../Blocks/MonthlyReadings/monthly_readings_bloc.dart';
import '../Blocks/ProcessSEUDialog/process_seudialog_bloc.dart';
import '../Blocks/SEU/seus_bloc.dart';
import '../Models/Generalmodel.dart';
import '../Models/MonthlyModel.dart';
import '../Models/SEUmodel.dart';
import '../Widgets/Constants/ConstantColors.dart';
import '../Widgets/constantWidgets/BKG.dart';
import '../Widgets/constantWidgets/GridViewBuilder.dart';
import 'SEUsGraphs.dart';



class Reports extends StatelessWidget {
  const Reports({super.key});




  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(providers: [
        BlocProvider(
        create: (context) => MonthlyReadingsBloc(
        RepositoryProvider.of<MonthlyReadingService>(context),RepositoryProvider.of<generalService>(context))..add(gettypes())
      ..add(gettingalldataevent()),

        ),
      BlocProvider(
        create: (context) =>
        SeusBloc(RepositoryProvider.of<SEUmodelservice>(context))
          ..add(gettingallseuevent()),

      ),
    ], child:  const BKG(
    page:Tunnel(),));

  }
}
class Tunnel extends StatefulWidget {
  const Tunnel({Key? key}) : super(key: key);

  @override
  State<Tunnel> createState() => _TunnelState();
}

class _TunnelState extends State<Tunnel> {
  var _selectedDate=DateTime.now();

  getyear() {
    return _selectedDate;
  }

  setyear(DateTime year){
    setState(() {
      _selectedDate=  year;
    });
  }

  _page(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: [
          ScreenTypeLayout(mobile:  ReportHeaderDesktop(getyear,setyear),desktop:
          ReportHeaderDesktop(getyear,setyear),tablet:   ReportHeaderDesktop(getyear,setyear),),
          ReportContent(_selectedDate.toString().split(" ")[0].split("-")[0])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("called");
    print(_selectedDate.toString().split(" ")[0].split("-")[0]);
    return _page(context);
  }
}



class ReportContent extends StatelessWidget {
  final String year;
  const ReportContent(this.year,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          children: [
            Text("Report of year $year",style:const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),),
           const SizedBox(height: 20,),
           const Text("Monthly data"),
            MonthlyGraphsReports(year),
            const Text("SEUs"),
            SEUSGraphs(hieght: MediaQuery.of(context).size.height/2,)
          ],
        ));
  }
}
class MonthlyGraphsReports extends StatelessWidget {
  final String year;

  const MonthlyGraphsReports(this.year,{Key? key}) : super(key: key);


  _page(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/2,
        margin: const EdgeInsets.symmetric(horizontal: 20,),
        width: double.infinity,
        child: BlocBuilder<MonthlyReadingsBloc, MonthlyReadingsState>(
            builder: (context, state) {
              if (state is MonthlyReadingsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<List<MonthlyModel>> temp = gettypesfunc(context);
              // return SizedBox();

              return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: ScreenTypeLayout(mobile: ListViewBuilder(temp,type: 'Monthly Readings Report',optional1: year,),
                    tablet: GridViewBuilder(temp,1  ,type: 'Monthly Readings Report',optional1: year
                    ),desktop:GridViewBuilder(temp,2,type: 'Monthly Readings Report',optional1: year) ,

                  )
              );
            }));
  }

  List<List<MonthlyModel>> gettypesfunc(BuildContext context) {

    List<MonthlyModel> temp =
        BlocProvider.of<MonthlyReadingsBloc>(context).Monthlylist;
    Set typesunique=<int>{};
    for (var el in temp) {
      typesunique.add(el.type);
    }


    List<List<MonthlyModel>> output = List.generate(typesunique.length,
            (index) => temp
            .where((element) => element.type == typesunique.elementAt(index))
            .toList());
    return output;

  }
  @override
  Widget build(BuildContext context) {
    return
      _page(context);
  }
}

// class ReportHeaderMobile extends StatelessWidget {
//   const ReportHeaderMobile({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color:customSelection,
//       ),
//       margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
//       padding: const EdgeInsets.all(10.0),
//       child: Wrap(
//         crossAxisAlignment: WrapCrossAlignment.center,
// alignment: WrapAlignment.spaceBetween,
//         children:  [
//           const Text("Create yearly Reports",style: TextStyle(fontWeight: FontWeight.bold),),
//           TextButton(onPressed: (){
//
//           }, child: const Text("Pick year"))
//         ],
//       ),
//     );
//   }
// }

class ReportHeaderDesktop extends StatelessWidget {
  final Function year,setyear;
   ReportHeaderDesktop(this.year,this.setyear, {Key? key}) : super(key: key);

  yearPicker(BuildContext context){
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor:customBtengan ,

        title: const Text("Select Year"),
        content: Container( // Need to use container to add size constraint.
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: customBtengan,
          ),
          height: 300,
          child: YearPicker(
            firstDate: DateTime(DateTime
                .now()
                .year - 100, 1),
            lastDate: DateTime(DateTime
                .now()
                .year + 100, 1),
            initialDate: DateTime.now(),
            // save the selected date to _selectedDate DateTime variable.
            // It's used to set the previous selected date when
            // re-showing the dialog.
            selectedDate: year(),
            onChanged: (DateTime dateTime) {
              // close the dialog when year is selected.
              setyear(dateTime);
              Navigator.pop(context);

              // Do something with the dateTime selected.
              // Remember that you need to use dateTime.year to get the year
            },
          ),
        ),
      );
    }
    );

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color:customSelection,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
           const Text("Create yearly Reports",style: TextStyle(fontWeight: FontWeight.bold),),
          TextButton(onPressed: (){
            yearPicker(context);
          }, child: const Text("Pick year"))
        ],
      ),
    );
  }
}
