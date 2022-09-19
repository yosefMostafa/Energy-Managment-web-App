import 'package:companywebapp/Models/Generalmodel.dart';
import 'package:companywebapp/Widgets/constantWidgets/Type_select.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../Blocks/ProcessSEUDialog/process_seudialog_bloc.dart';
import '../Blocks/SEU/seus_bloc.dart';
import '../Models/SEUmodel.dart';
import '../Modules/excelload.dart';
import '../Widgets/Constants/ConsttextField.dart';
import '../Widgets/constantWidgets/BKG.dart';
import '../Widgets/constantWidgets/CustomDialoge.dart';
import '../Widgets/constantWidgets/ThreeButtonDesign.dart';
import '../Widgets/constantWidgets/generateTable.dart';

class AddSEUView extends StatelessWidget {
  AddSEUView({Key? key}) : super(key: key);
  SEUmodel temp = SEUmodel();

  _showAddprocesDialoge(BuildContext context, Function save) {
    showDialog(
        useRootNavigator: false,
        context: context,
        builder: (BuildContext context) => CustomDialoge(
              save: save,
              title: "Add New process",
              content: [

                {
                  'title': 'Name of SEU',
                  'widget': textFielddesign((String val) {
                    temp.name = val;
                  }),
                },
                {
                  'title': 'Main Driver',
                  'widget': textFielddesign((String val) {
                    temp.driver=val;
                  }),
                },
                {
                  'title': 'Meter type',
                  'widget': textFielddesign((String val) {
                    temp.meter_type=val;
                  }),
                },
                {
                  'title': 'Kwh p.a',
                  'widget': textFielddesign((String val) {
                    temp.wpa =  double.parse(val);
                  }, keboardtype: TextInputType.number),
                },
                {
                  'title': 'Energy influencer',
                  'widget': textFielddesign((String val) {
                    temp.influencer=val;
                  }),
                },
                {
                  'title': 'Objective',
                  'widget': textFielddesign((String val) {
                  temp.objective=val;
                  }),
                },
                {
                  'title': 'Type',
                  'widget': textFielddesign((String val) {
                    print(val);
                  }),
                },
                {
                  'title': 'Target Kwh',
                  'widget': textFielddesign((String val) {
                    temp.targetkwh=double.parse(val);
                  }, keboardtype: TextInputType.number),
                },
                {
                  'title': 'EnPI',
                  'widget': textFielddesign((String val) {
                    temp.ENPI = val;
                  }, keboardtype: TextInputType.number),
                },
              ],
            ));
  }

  _page(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      child: Column(
        children: [
          BlocBuilder<SeusBloc, SeusState>(
            builder: (context, state) {
              return ThreeButtoDesign(
                actions: [
                  () {
                    _showAddprocesDialoge(context, () {
                      BlocProvider.of<SeusBloc>(context)
                          .add(AddSEU(temp.copyWith()));
                      temp = SEUmodel();
                    });
                  },
                  () {},
                  () {
                    try {
                      getExceldata("SEUs").then((value) {
                        if (value.isNotEmpty) {
                          BlocProvider.of<SeusBloc>(context)
                              .add(ADDSEUlist(value["data"]));
                        }
                      });
                    } catch (e) {
                      print(e.toString());
                    }
                  }
                ],
                exception: 1,
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
                // TypeSelect(
                //   data: general.types,
                //   value: 'gas',
                // ),
                BlocBuilder<SeusBloc, SeusState>(
                  builder: (context, state) {
                    if (state is SEUlistchanged) {
                      return GenerateTable((compare){
                        BlocProvider.of<SeusBloc>(context).add(Sortseuevent(compare));
                      },
                        titles: const [{"title":'type','type':'string'},{"title":'wpa','type':'int'}, {"title":'target','type':'int'}],
                        data: state.sEUlist,
                      );
                    } else {
                      return GenerateTable((compare){
                        BlocProvider.of<SeusBloc>(context).add(Sortseuevent(compare));
                      },
                        titles:  const [{"title":'type','type':'string'},{"title":'wpa','type':'int'}, {"title":'target','type':'int'}],
                        data: const [],
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SeusBloc( RepositoryProvider.of<SEUmodelservice>(context))..add(gettingallseuevent()),
      child: BKG(
        page: _page(context),
      ),
    );
  }
}
