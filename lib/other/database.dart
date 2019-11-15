import 'dart:convert';
import 'dart:io';

import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:path_provider/path_provider.dart';

class Database {
  static final Database _singleton = Database._internal();

  factory Database() {
    return _singleton;
  }

  Database._internal();

  Future<List<PojoGroup>> getGroups() async{
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/groups.json');
      print("Groups loaded!");
      String text = await file.readAsString();

      Iterable iter = jsonDecode(text).cast<Map<String, dynamic>>();
      List<PojoGroup> groups = iter.map<PojoGroup>((json) => PojoGroup.fromJson(json)).toList();
      return groups;
    } catch (e) {
      print("Couldn't read file " + e.toString());
    }
  }

  Future<void> saveGroups(List<PojoGroup> groups) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/groups.json');
    final text = jsonEncode(groups);
    await file.writeAsString(text);
    print('Groups saved!');
  }

}

