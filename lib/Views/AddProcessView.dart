import 'dart:io';

import 'package:companywebapp/Widgets/Constants/ConstantColors.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

import '../Blocks/bloc_exports.dart';
import '../Blocks/processSEU/process_seu_bloc.dart';
import '../Models/LightinigModel.dart';
import '../Models/ProcessSEUmodel.dart';
import '../Modules/excelload.dart';
import '../Widgets/Constants/ConsttextField.dart';
import '../Widgets/constantWidgets/BKG.dart';
import '../Widgets/constantWidgets/CustomDialoge.dart';
import '../Widgets/constantWidgets/ThreeButtonDesign.dart';
import '../Widgets/constantWidgets/generateTable.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:file_picker/file_picker.dart';

class AddProcessView extends StatelessWidget {
  AddProcessView({Key? key}) : super(key: key);
  ProcessSEUmodel tempprocess = ProcessSEUmodel();
  LightinigModel tempLight = LightinigModel();
  List<Map> titles = [];
  List dataSEU = [];
  List dataLight = [];
  String group = 'SEU';
  _showAddprocesDialoge(BuildContext context, String group, Function save) {
    final List<Map> SEUs = [
      {
        'title': 'Month',
        'widget': customDatePicker(context, () async {
          showMonthYearPicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2023),
          )
              .then(
                  (value) => tempprocess.month = value.toString().split(" ")[0])
              .then((value) => print(tempprocess.month));
        }),
      },
      {
        'title': 'Purpose',
        'widget': textFielddesign((String val) {
          tempprocess.purpose = val;
        }),
      },
      {
        'title': 'Name plate',
        'widget': textFielddesign((String val) {
          print(val);
        }),
      },
      {
        'title': 'SEU',
        'widget': textFielddesign((String val) {
          tempprocess.SEU = val;
        }, keboardtype: TextInputType.number),
      },
      {
        'title': 'Usage',
        'widget': textFielddesign((String val) {
          tempprocess.usage = val;
        }),
      },
      {
        'title': 'Hours per month',
        'widget': textFielddesign((String val) {
          tempprocess.hpmonth = val;
        }),
      },
      {
        'title': 'Ave VSD speed (100% if fixed)',
        'widget': textFielddesign((String val) {
          print(val);
        }),
      },
      {
        'title': 'Note',
        'widget': textFielddesign((String val) {
          print(val);
        }, keboardtype: TextInputType.number),
      },
      {
        'title': 'Switched of times',
        'widget': textFielddesign((String val) {
          print(val);
        }, keboardtype: TextInputType.number),
      },
    ];
    final List<Map> Light = [
      {
        'title': 'Month',
        'widget': customDatePicker(context, () {
          showMonthYearPicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2023),
          )
              .then((value) => tempLight.month = value.toString().split(" ")[0])
              .then((value) => print(tempLight.month));
        }),
      },
      {
        'title': 'Area',
        'widget': textFielddesign((String val) {
          tempLight.area = val;
        }),
      },
      {
        'title': 'Category',
        'widget': textFielddesign((String val) {
          tempLight.catergory = val;
        }),
      },
      {
        'title': 'Type of Fitting',
        'widget': textFielddesign((String val) {
          tempLight.fitting = val;
        }),
      },
      {
        'title': 'Number of fittings',
        'widget': textFielddesign((String val) {
          tempLight.num_of_fitting = val;
        }, keboardtype: TextInputType.number),
      },
      {
        'title': 'Lamp rating (W)',
        'widget': textFielddesign((String val) {
          print(val);
        }, keboardtype: TextInputType.number),
      },
      {
        'title': 'Number of Lamps/ fittings',
        'widget': textFielddesign((String val) {
          print(val);
        }, keboardtype: TextInputType.number),
      },
    ];
    showDialog(
      useRootNavigator: false,
      context: context,
      builder: (BuildContext context) => CustomDialoge(
        title: "Add New process",
        content: group == 'SEU' ? SEUs : Light,
        save: save,
      ),
    );
  }

  _page(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<ProcessSeuBloc, ProcessSeuState>(
              builder: (context, state) {
                return ThreeButtoDesign(
                  actions: [
                    () {
                      // Dialog errorDialog = ;

                      _showAddprocesDialoge(context, group, () {
                        if (group == 'SEU') {
                          BlocProvider.of<ProcessSeuBloc>(context)
                              .add(Addprocess(tempprocess.copyWith()));
                          tempprocess = ProcessSEUmodel();
                        } else {
                          BlocProvider.of<ProcessSeuBloc>(context)
                              .add(AddLight(tempLight.copyWith()));
                          tempLight = LightinigModel();
                        }
                      });
                    },
                    () {},
                    () {
                      try {
                        if (group == 'SEU') {
                          getExceldata('processSEU').then((value) {
                            if (value.isNotEmpty) {
                              BlocProvider.of<ProcessSeuBloc>(context)
                                  .add(AddprocessList(value["data"]));
                            }
                          });
                        } else {
                          getExceldata('lightSEU').then((value) {
                            if (value.isNotEmpty) {
                              BlocProvider.of<ProcessSeuBloc>(context)
                                  .add(AddLightList(value["data"]));
                            }
                          });
                        }
                      } catch (e) {
                        print(e.toString());
                      }
                    }
                  ],
                  extraheaders: BlocBuilder<ProcessSeuBloc, ProcessSeuState>(
                      builder: (context, state) {
                    if (state is GroupState) {
                      group = state.group;
                    }
                    return Row(
                      children: [
                        Radio<String>(
                          activeColor: customBtengan,
                          value: 'SEU',
                          onChanged: (value) {
                            BlocProvider.of<ProcessSeuBloc>(context)
                                .add(GroupEvent(value!));
                          },
                          groupValue: group,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        const Text('SEU users'),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Radio<String>(
                          activeColor: customBtengan,
                          value: 'Lightining',
                          onChanged: (value) {
                            BlocProvider.of<ProcessSeuBloc>(context)
                                .add(GroupEvent(value!));
                          },
                          groupValue: group,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        const Text('Lightining'),
                      ],
                    );
                    ;
                  }),
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            // const Expanded(child: SizedBox()),
            Align(
              alignment: Alignment.bottomCenter,
              child: BlocBuilder<ProcessSeuBloc, ProcessSeuState>(
                builder: (context, state) {
                  if (state is GroupState) {

                    if( group != 'SEU'){
                      titles=const [
                        {"title": 'month', "type": 'date'},
                        {"title": 'area', "type": 'string'},
                        {"title": 'catergory', "type": 'string'},
                        {"title": 'fitting', "type": 'string'},
                        {"title": 'num_of_fitting', "type": 'int'}
                      ];
                    }else{
                      titles=const [
                        {"title": 'month', "type": 'date'},
                        {"title": 'purpose', "type": 'string'},
                        {"title": 'hpmonth', "type": 'int'},
                        {"title": 'usage', "type": 'int'},
                        {"title": 'SEU', "type": 'string'}
                      ];
                    }


                  } else if (state is ProcessListState) {
                    dataSEU = state.processlist;
                  } else if (state is LightListState) {
                    dataLight = state.Lightlist;
                  }

                  return titles.isEmpty?const SizedBox(): GenerateTable(
                    (compare){

                    },
                    titles: titles,
                    data: group == 'SEU' ? dataSEU : dataLight,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProcessSeuBloc(RepositoryProvider.of<ProcessSEUservice>(context),RepositoryProvider.of<LightinigService>(context))..add(GroupEvent('SEU')),
      child: BKG(
        page: _page(context),
      ),
    );
  }
}
