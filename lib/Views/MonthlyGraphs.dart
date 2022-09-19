import 'package:companywebapp/Widgets/Constants/ConstantColors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../Blocks/MonthlyReadings/monthly_readings_bloc.dart';
import '../Blocks/ProcessSEUDialog/process_seudialog_bloc.dart';
import '../Models/Generalmodel.dart';
import '../Models/MonthlyModel.dart';
import '../Widgets/constantWidgets/BKG.dart';
import '../Widgets/constantWidgets/GridViewBuilder.dart';

class MonthlyGraphs extends StatelessWidget {
  const MonthlyGraphs({Key? key}) : super(key: key);

  _page(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
              child: ScreenTypeLayout(mobile: ListViewBuilder(temp,type: 'Monthly Readings',),
                tablet: GridViewBuilder(temp,1  ,type: 'Monthly Readings',),desktop:GridViewBuilder(temp,2,type: 'Monthly Readings',) ,

              )
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    print("Monthly graphs");
    return Scaffold(
        backgroundColor: customGrey,
        // appBar: AppBar(),
        body: Stack(
          children: [
            BlocProvider(
              create: (context) => MonthlyReadingsBloc(
                  RepositoryProvider.of<MonthlyReadingService>(context),RepositoryProvider.of<generalService>(context))..add(gettypes())
                ..add(gettingalldataevent()),
              child: _page(context),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ));
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
}
