import 'package:companywebapp/Widgets/Constants/ConstantColors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Blocks/ProcessSEUDialog/process_seudialog_bloc.dart';
import '../Blocks/SEU/seus_bloc.dart';

import '../Models/SEUmodel.dart';

import '../Widgets/constantWidgets/GridViewBuilder.dart';


class SEUSGraphs extends StatelessWidget {
  final double? hieght;

  const SEUSGraphs({Key? key,this.hieght}) : super(key: key);

  _page(BuildContext context) {
    return Container(
      height: hieght,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        child: BlocBuilder<SeusBloc, SeusState>(builder: (context, state) {
          if (state is SEUsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // List<List<MonthlyModel>> temp = gettypesfunc(context);
          // return SizedBox();
          List<Widget> temp = const [BarChartSEUCard()];
          return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ScreenTypeLayout(
                mobile: ListViewBuilder(
                  temp,
                  type: 'SEUs',
                ),
                tablet: GridViewBuilder(
                  temp,
                  1,
                  type: 'SEUs',
                ),
                desktop: GridViewBuilder(
                  temp,
                  2,
                  type: 'SEUs',
                ),
              ));
        }));
  }

  @override
  Widget build(BuildContext context) {
    print("Monthly graphs");
    return hieght != null? _page(context):Scaffold(
        backgroundColor: customGrey,
        // appBar: AppBar(),
        body: Stack(
          children: [
            BlocProvider(
              create: (context) =>
                  SeusBloc(RepositoryProvider.of<SEUmodelservice>(context))
                    ..add(gettingallseuevent()),
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

//   List<List<MonthlyModel>> gettypesfunc(BuildContext context) {
//
//     List<MonthlyModel> temp =
//         BlocProvider.of<MonthlyReadingsBloc>(context).Monthlylist;
//     Set typesunique=<int>{};
//     for (var el in temp) {
//       typesunique.add(el.type);
//     }
//
//
//     List<List<MonthlyModel>> output = List.generate(typesunique.length,
//             (index) => temp
//             .where((element) => element.type == typesunique.elementAt(index))
//             .toList());
//     return output;
//
//   }
}

class BarChartSEUCard extends StatelessWidget {
  const BarChartSEUCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ResponsiveBuilder(builder: (context, si) {
          return Column(children: [
            Flexible(
              flex: si.isMobile ? 0 : 1,
              child: SfCartesianChart(
                  tooltipBehavior: TooltipBehavior(enable: true),
                  selectionType: SelectionType.series,
                  legend:
                      Legend(isVisible: true, position: LegendPosition.bottom),
                  enableAxisAnimation: true,
                  primaryXAxis: CategoryAxis(
                      labelRotation: si.isMobile ? -50 : 0,
                      title: AxisTitle(
                        text: 'Process name',
                      )),
                  primaryYAxis: NumericAxis(
                      title: AxisTitle(
                    text: "wpa & target",
                  )),
                  title: ChartTitle(
                      text: 'Yearly Readings chart (Month) vs wpa & target'),
                  series: <ChartSeries<SEUmodel, dynamic>>[
                    ColumnSeries<SEUmodel, dynamic>(
                        selectionBehavior: SelectionBehavior(
                          enable: true,
                          unselectedOpacity: 0.5,
                        ),
                        dataSource: BlocProvider.of<SeusBloc>(context).sEUlist,
                        xValueMapper: (SEUmodel data, _) => data.name,
                        yValueMapper: (SEUmodel data, _) => data.wpa,
                        name: "wpa"
                        // name: "wpa & target",
                        // Enable data label
                        ),
                    ColumnSeries<SEUmodel, dynamic>(
                        selectionBehavior: SelectionBehavior(
                          enable: true,
                          unselectedOpacity: 0.5,
                        ),
                        dataSource: BlocProvider.of<SeusBloc>(context).sEUlist,
                        xValueMapper: (SEUmodel data, _) => data.name,
                        yValueMapper: (SEUmodel data, _) => data.targetkwh,
                        name: "Target"
                        // name: "wpa & target",
                        // Enable data label
                        )
                  ]),
            ),
          ]);
        }),
      ),
    );
  }
}
