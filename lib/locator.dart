import 'package:companywebapp/services/Navigationservice.dart';
import 'package:get_it/get_it.dart';

GetIt locator =GetIt.instance;


void setuplocator(){
locator.registerLazySingleton(() => Navigationservice());
}