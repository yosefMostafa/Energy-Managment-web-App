import 'package:companywebapp/Models/MonthlyModel.dart';
import 'package:companywebapp/Widgets/constantWidgets/Type_select.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Blocks/MonthlyReadings/monthly_readings_bloc.dart';
import '../../Blocks/ProcessSEUDialog/process_seudialog_bloc.dart';
import '../../Modules/Convertions.dart';

class MonthlyGraphsCardReport extends StatefulWidget {
  final List<MonthlyModel> data;
  final String year;
  const MonthlyGraphsCardReport(this.data, this.year, {Key? key})
      : super(key: key);

  @override
  State<MonthlyGraphsCardReport> createState() =>
      _MonthlyGraphsCardReportState();
}

class _MonthlyGraphsCardReportState extends State<MonthlyGraphsCardReport> {
  List<MonthlyModel> viewedList = [];

  List allydata = ["cost", "usage"];

  @override
  initState() {
    super.initState();

    getViewdList();
  }

  getViewdList() {
    viewedList = widget.data
        .where((element) => element.month.split("-")[0] == widget.year)
        .toList();
    print(viewedList);
  }

  didUpdateWidget(MonthlyGraphsCardReport t) {
    super.didUpdateWidget(t);
    viewedList = widget.data
        .where((element) => element.month.split("-")[0] == widget.year)
        .toList();
    print(viewedList);
  }

  _getHeaders() {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 15,
      crossAxisAlignment: WrapCrossAlignment.center,
      // crossAxisAlignment: WrapCrossAlignment.,
      children: [
        Text(
          "Type: ${BlocProvider.of<MonthlyReadingsBloc>(context).types.singleWhere((element) => element.id == widget.data[0].type).name}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text("year: ${widget.year}"),
          ],
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: const [
            Text("ydata: cost & usage"),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // print("years =" );
    // print(years);
    // print(viewedList);
    // return SizedBox();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ResponsiveBuilder(builder: (context, si) {
          return Column(children: [
            _getHeaders(),
            Flexible(
              flex: si.isMobile ? 0 : 1,
              child: SfCartesianChart(
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                  ),
                  selectionType: SelectionType.series,
                  enableAxisAnimation: true,
                  primaryXAxis: DateTimeAxis(
                      title: AxisTitle(
                    text: 'year',
                  )),
                  primaryYAxis: NumericAxis(
                      numberFormat: NumberFormat.compact(),
                      title: AxisTitle(
                    text: "cost & usage",
                  )),
                  series: allydata
                      .map<ChartSeries<MonthlyModel, dynamic>>(
                          (e) => StackedColumnSeries<MonthlyModel, dynamic>(
                                selectionBehavior: SelectionBehavior(
                                  enable: true,
                                ),
                                dataSource: viewedList,
                                xValueMapper: (MonthlyModel data, _) =>
                                    toDateTime(data.month),
                                yValueMapper: (MonthlyModel data, _) =>
                                    e == 'cost' ? data.cost : data.usage,
                                name: e,
                                // Enable data label
                              ))
                      .toList()),
            ),
          ]);
        }),
      ),
    );
  }
}
