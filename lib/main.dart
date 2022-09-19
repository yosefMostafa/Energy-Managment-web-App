import 'package:companywebapp/Blocks/bloc_exports.dart';
import 'package:companywebapp/Models/MonthlyModel.dart';
import 'package:companywebapp/Widgets/Constants/ConstantColors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'Models/Generalmodel.dart';
import 'Models/LightinigModel.dart';
import 'Models/ProcessSEUmodel.dart';
import 'Models/SEUmodel.dart';
import 'locator.dart';
import 'package:flutter/material.dart';

import 'Widgets/Navigation/NavigationView.dart';

void main() {
  setuplocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

// Green color code: FF93cd48MaterialColor customColor = MaterialColor(0xFF93cd48, colorCodes);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xff917b3f, {
          50: customSelection,
          100: customSelection,
          200: customSelection,
          300: customSelection,
          400: customSelection,
          500: customSelection,
          600: customSelection,
          700: customSelection,
          800: customSelection,
          900: customSelection,
        }),
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => MonthlyReadingService()),
          RepositoryProvider(create: (context) => generalService()),
          RepositoryProvider(create: (context) => SEUmodelservice()),
          RepositoryProvider(create: (context) => ProcessSEUservice()),
          RepositoryProvider(create: (context) => LightinigService())
        ],
        child: NavigationView(),
      ),
    );
  }
}
