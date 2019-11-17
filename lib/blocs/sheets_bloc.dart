import 'package:bloc/bloc.dart';
import 'package:dusza2019/managers/sheets_manager.dart';
import 'package:dusza2019/resources/csv_student.dart';
import 'package:dusza2019/resources/pojos/pojo_group.dart';
import 'package:dusza2019/resources/pojos/pojo_student.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class SheetEvent extends Equatable {
  SheetEvent([List props = const []]) : super(props);
}

abstract class SheetState extends Equatable {
  SheetState([List props = const []]) : super(props);
}

class StartupEvent extends SheetEvent {
  @override
  String toString() => 'StartupEvent';
}

class CreateTemplateFileEvent extends SheetEvent {
  final Map<String, String> headers;

  CreateTemplateFileEvent(this.headers);

  @override
  String toString() => 'CreateTemplateFileEvent';
}

class OpenTemplateFileEvent extends SheetEvent {
  @override
  String toString() => 'OpenTemplateFileEvent';
}

class RemoveTemplateFileEvent extends SheetEvent {
  @override
  String toString() => 'RemoveTemplateFileEvent';
}

class ImportDataEvent extends SheetEvent {
  final Map<String, String> headers;

  ImportDataEvent(this.headers);

  @override
  String toString() => 'ImportDataEvent';
}

class LoadingState extends SheetState {
  @override
  String toString() => 'LoadingState';
}

class NoTemplateState extends SheetState {
  @override
  String toString() => 'NoTemplate';
}

class TemplateReadyState extends SheetState {
  final String fileId;

  TemplateReadyState(this.fileId);

  @override
  String toString() => 'ImportReady';
}

class ImportReadyState extends SheetState {
  final List<CSVStudent> students;

  ImportReadyState(this.students);

  @override
  String toString() => 'ImportReadyState';
}

class SheetBloc extends Bloc<SheetEvent, SheetState> {
  String _fileId;

  @override
  SheetState get initialState => LoadingState();

  @override
  Stream<SheetState> mapEventToState(SheetEvent event) async* {
    switch (event.runtimeType) {
      case StartupEvent:
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String fileId = prefs.getString("SheetsID");
        print("FileId $fileId");
        if(fileId == null){
          yield NoTemplateState();
        }else {
          _fileId = fileId;
          yield TemplateReadyState(_fileId);
        }

        break;
      case CreateTemplateFileEvent:
        yield LoadingState();
        CreateTemplateFileEvent e = event;
        _fileId = await SheetsManager().createSpreadsheet(e.headers);
        yield TemplateReadyState(_fileId);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("SheetsID", _fileId);
        break;
      case OpenTemplateFileEvent:
        String fileUrl = "https://docs.google.com/spreadsheets/d/$_fileId";
        await launch(fileUrl);

        break;
      case RemoveTemplateFileEvent:
        yield NoTemplateState();
        _fileId = null;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("SheetsID", null);
        break;
      case ImportDataEvent:
        yield LoadingState();
        ImportDataEvent e = event;
        print("Importing from Sheets...");
        List<CSVStudent> student = await SheetsManager().readSpreadsheet(e.headers, _fileId);
        yield ImportReadyState(student);
        break;
    }
  }
}
