import 'package:dusza2019/managers/felelek_localizations.dart';
import 'package:dusza2019/managers/google_client.dart';
import 'package:dusza2019/resources/csv_student.dart';
import 'package:googleapis/sheets/v4.dart';

class SheetsManager {
  static final SheetsManager _singleton = SheetsManager._internal();

  factory SheetsManager() {
    return _singleton;
  }

  SheetsManager._internal();

  Future<String> createSpreadsheet(Map<String, String> headers) async {
    final httpClient = GoogleHttpClient(headers);
    Spreadsheet spreadsheet = Spreadsheet();
    var data = await SheetsApi(httpClient).spreadsheets.create(spreadsheet);

    try {
      BatchUpdateSpreadsheetRequest requests =
          new BatchUpdateSpreadsheetRequest();
      requests.requests = new List();

      Request changeName = new Request();
      changeName.updateSpreadsheetProperties =
          new UpdateSpreadsheetPropertiesRequest();
      changeName.updateSpreadsheetProperties.fields = "*";
      changeName.updateSpreadsheetProperties.properties =
          new SpreadsheetProperties();
      changeName.updateSpreadsheetProperties.properties.title =
          "FelElek template";

      Request defaultData = new Request();
      defaultData.pasteData = new PasteDataRequest();
      defaultData.pasteData.coordinate = new GridCoordinate();
      defaultData.pasteData.coordinate
        ..sheetId = 0
        ..rowIndex = 0
        ..columnIndex = 0;
      defaultData.pasteData.data =
          "${await locTextContextless(key: "templateStudentName")};"
          "${await locTextContextless(key: "templateGradesAmount")};"
          "${await locTextContextless(key: "templateGroupName")}";
      defaultData.pasteData.type = "PASTE_VALUES";
      defaultData.pasteData.delimiter = ";";

      requests.requests.add(changeName);
      requests.requests.add(defaultData);
      await SheetsApi(httpClient)
          .spreadsheets
          .batchUpdate(requests, data.spreadsheetId);
    } catch (ex) {
      print("Exception while updateing template $ex");
    }

    return data.spreadsheetId;
  }

  Future<List<CSVStudent>> readSpreadsheet(
      Map<String, String> headers, String fileId) async {
    final httpClient = GoogleHttpClient(headers);
    var data = await SheetsApi(httpClient)
        .spreadsheets
        .get(fileId, includeGridData: true);
    List<RowData> rowData = data.sheets[0].data[0].rowData;
    List<CSVStudent> students = new List();

    for (int i = 0; i < rowData.length; i++) {
      RowData data = rowData[i];
      String name = data.values[0].effectiveValue.stringValue;
      int gradesAmount = 0;
      try {
        gradesAmount = data.values[1].effectiveValue.numberValue.floor();
      } catch (ex) {}
      String groupName = data.values[2].effectiveValue.stringValue;
      CSVStudent student = new CSVStudent(name, gradesAmount, groupName);
      students.add(student);
    }
    return students;
  }
}
