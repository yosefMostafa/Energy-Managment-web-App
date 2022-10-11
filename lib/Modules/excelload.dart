import 'package:companywebapp/Models/SEUmodel.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import '../Models/LightinigModel.dart';
import '../Models/MonthlyModel.dart';
import '../Models/ProcessSEUmodel.dart';

Future<Map> getExceldata(String type) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, allowMultiple: false, allowedExtensions: ['xlsx']);
  if (result != null) {
    PlatformFile file = result.files.first;
    if (file.extension == 'xlsx') {
      var bytes = file.bytes;
      Excel excel = Excel.decodeBytes(bytes!);
      for (var table in excel.tables.keys) {
        try {
          switch (type) {
            case 'Month Energy':
              return readEnergymonthly(excel, table);
            case 'SEUs':
              return readSEUsmonthly(excel, table);
            case 'processSEU':
              return readprocessSEU(excel,table);
            case 'lightSEU':
              return readlightSEU(excel,table);
            default:
              return readEnergymonthly(excel, table);
          }
        } catch (e) {
          throw e;
        }
      }
    }
  }
  return {};
}
Map readlightSEU(Excel excel, String table) {
  Map output = {'data': <LightinigModel>[]};
  // print(excel.tables[table]?.maxCols);
  int maxRows = excel.tables[table]!.maxRows;
  // output['type'] = excel.tables[table]!
  //     .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 9))
  //     .value
  //     .toString();

  for (int i = 2; i < maxRows; i++) {
    LightinigModel rowdata=LightinigModel();
    rowdata.month = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i))
        .value
        .toString()
        .split("T")[0];
    rowdata.area = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i))
        .value
        .toString();
    rowdata.catergory = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i))
        .value
        .toString();
    rowdata.fitting = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex:4, rowIndex: i))
        .value
        .toString();
    rowdata.num_of_fitting = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i))
        .value
        .toString();
    rowdata.lamp_rating = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i))
        .value
        .toString();
    rowdata.num_oflamps = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i))
        .value
        .toString();
    rowdata.hpmonth = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i))
        .value
        .toString();
    rowdata.light_controle = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i))
        .value
        .toString();
    rowdata.improvements = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i))
        .value
        .toString();
    rowdata.lusx_levels = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i))
        .value
        .toString();
    rowdata.natural_light = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: i))
        .value
        .toString();
    rowdata.Required_lux_level = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: i))
        .value
        .toString();
    rowdata.Actual_lux_level = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: i))
        .value
        .toString();
    print(rowdata.toMap());
    output["data"].add(rowdata);
  }
  return output;
}
Map readprocessSEU(Excel excel, String table) {

  Map output = {'data': <ProcessSEUmodel>[]};
  // print(excel.tables[table]?.maxCols);
  int maxRows = excel.tables[table]!.maxRows;
  // output['type'] = excel.tables[table]!
  //     .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 9))
  //     .value
  //     .toString();

  for (int i = 10; i < maxRows; i++) {
    ProcessSEUmodel rowdata=ProcessSEUmodel();
    rowdata.month = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i))
        .value
        .toString()
        .split("T")[0];
    rowdata.purpose = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i))
        .value
        .toString();
    rowdata.name = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i))
        .value
        .toString();

    rowdata.hpmonth = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex:4, rowIndex: i)).value.toString();

    rowdata.VSD = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex:5, rowIndex: i))
        .value
        .toString();
    rowdata.nameplateload = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex:6, rowIndex: i))
        .value
        .toString();
    rowdata.note = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex:7, rowIndex: i))
        .value
        .toString();
    rowdata.switched_off_times = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex:8, rowIndex: i))
        .value
        .toString();
    rowdata.estimates = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex:9, rowIndex: i))
        .value
        .toString();
    rowdata.improvement = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex:10, rowIndex: i))
        .value
        .toString();
    rowdata.SEU = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex:11, rowIndex: i))
        .value
        .toString();
    output["data"].add(rowdata);
  }
  return output;
}
Map readSEUsmonthly(Excel excel, String table) {
  Map output = {'data': <SEUmodel>[]};
  // print(excel.tables[table]?.maxCols);
  int maxRows = excel.tables[table]!.maxRows;
  // output['type']= excel.tables[table]!
  //     .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 9))
  //     .value
  //     .toString();
  print(maxRows);
  for (int i = 11; i < maxRows; i++) {
    SEUmodel rowdata=SEUmodel();
    rowdata.name = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i))
        .value
        .toString();
    rowdata.driver = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i))
        .value
        .toString();

    rowdata.meter_type= excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i))
        .value
        .toString();
    rowdata.wpa = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i))
        .value
        ;
    rowdata.influencer= excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i))
        .value
        .toString();
    rowdata.objective= excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex:7, rowIndex: i))
        .value
        .toString();
    rowdata.targetkwh= excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex:8, rowIndex: i))
        .value
        ;
    rowdata.ENPI= excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex:9, rowIndex: i))
        .value
        .toString();
    output["data"].add(rowdata);
    print(output["data"][0].toMap());
  }

  return output;
}
Map readEnergymonthly(Excel excel, String table) {
  Map output = {'data': <MonthlyModel>[]};
  // print(excel.tables[table]?.maxCols);
  int maxRows = excel.tables[table]!.maxRows;
  output['type'] = excel.tables[table]!
      .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 9))
      .value
      .toString();

  for (int i = 11; i < maxRows; i++) {
    print(excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i))
        .value);
    String month = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i))
        .value
        .toString()
        .split("T")[0];
    print(month);
    String usage = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i))
        .value
        .toString();
    print(usage);
    String cost = excel.tables[table]!
        .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i))
        .value
        .toString();
    print(cost);
    output["data"].add(MonthlyModel(cost: int.parse(cost), month: month, usage: int.parse(usage)));
  }
  return output;
}
