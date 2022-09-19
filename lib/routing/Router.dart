import 'package:companywebapp/Views/EnergyReading.dart';
import 'package:companywebapp/routing/route_names.dart';
import 'package:flutter/material.dart';

import '../Views/AddProcessView.dart';
import '../Views/AddSEUView.dart';
import '../Views/Graphs.dart';
import '../Views/HomeView.dart';
import '../Views/Reports.dart';
import '../Views/SensorRefrenceView.dart';

Route<dynamic> generateroute(RouteSettings settings) {
  switch (settings.name) {
    case HOME:
      return _getpageroute(const HomeView());
    case ENERGYREADINGS:
      return _getpageroute( EnergyReadings());
    case SEUPAGE:
      return _getpageroute( AddSEUView());
    case SENSORREF:
      return _getpageroute(const SensoreRefrenceView());

    case REPORTS:
      return _getpageroute( const Reports());
    case GRAPHS:
      return _getpageroute(  GraphsGrid());
    case PROCESSPAGE:
      return _getpageroute( AddProcessView());
    default:
      return _getpageroute(const HomeView());
  }
}

PageRoute _getpageroute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
