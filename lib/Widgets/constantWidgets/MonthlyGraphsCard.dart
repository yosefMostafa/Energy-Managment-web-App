import 'package:companywebapp/Models/MonthlyModel.dart';
import 'package:companywebapp/Widgets/constantWidgets/Type_select.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Blocks/MonthlyReadings/monthly_readings_bloc.dart';
import '../../Blocks/ProcessSEUDialog/process_seudialog_bloc.dart';
import '../../Modules/Convertions.dart';

class MonthlyGraphsCard extends StatefulWidget {
  final List<MonthlyModel> data;
  const MonthlyGraphsCard(this.data, {Key? key}) : super(key: key);

  @override
  State<MonthlyGraphsCard> createState() => _MonthlyGraphsCardState();
}

class _MonthlyGraphsCardState extends State<MonthlyGraphsCard> {
  List<MonthlyModel> viewedList = [];
  Set<String> years = <String>{};
  late String _selectedyear;
  List allydata = ["cost", "usage"];
  String _selectedydata = "cost";

  @override
  initState() {
    super.initState();
    print("Card");
    print(widget.data);
    getyears();
    getViewdList();
  }

  getViewdList() {
    _selectedyear = years.elementAt(0);

    viewedList = widget.data
        .where((element) => element.month.split("-")[0] == years.elementAt(0))
        .toList();
  }

  getyears() {
    print(years);
    for (var element in widget.data) {
      years.add(element.month.split("-")[0]);
    }
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
            const Text("year: "),
            TypeSelect(
                data: years.toList(),
                value: _selectedyear,
                change: (value) {
                  setState(() {
                    _selectedyear = value;
                    viewedList = widget.data
                        .where((element) =>
                            element.month.split("-")[0] == _selectedyear)
                        .toList();
                  });
                }),
          ],
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text("ydata: "),
            TypeSelect(
                data: allydata,
                value: _selectedydata,
                change: (value) {
                  setState(() {
                    _selectedydata = value;
                  });
                }),
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
                  enableAxisAnimation: true,
                  primaryXAxis: DateTimeAxis(
                      dateFormat: DateFormat.MMM(),
                      title: AxisTitle(
                        text: 'Month',
                      )),
                  primaryYAxis: NumericAxis(
                    numberFormat: NumberFormat.compact(),
                      title: AxisTitle(
                          text: _selectedydata +
                              (_selectedydata == 'cost' ? ' (USD)' : ' kWh'))),
                  title: ChartTitle(
                      text: 'Yearly Readings chart (Month) vs $_selectedydata'),
                  series: <ChartSeries<MonthlyModel, dynamic>>[
                    ColumnSeries<MonthlyModel, dynamic>(
                        dataSource: viewedList,
                        xValueMapper: (MonthlyModel data, _) =>
                            toDateTime(data.month),
                        yValueMapper: (MonthlyModel data, _) =>
                            _selectedydata == 'cost' ? data.cost : data.usage,
                        name: _selectedydata,
                        // Enable data label
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true))
                  ]),
            ),
          ]);
        }),
      ),
    );
  }
}
