import 'dart:convert';
import 'dart:io';

import 'package:dusza2019/pojos/pojo_group.dart';
import 'package:http/http.dart';
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
      String json = await file.readAsString();

      return _jsonToGroups(json);
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

  Future<String> getDBFileIdFromDrive(String accessToken) async {
    final Map<String, String> queryParameters = {
      'spaces': 'appDataFolder',
      'q': 'name = "groups.json"',
    };
    final headers = { 'Authorization': 'Bearer $accessToken' };
    final uri = Uri.https('www.googleapis.com', '/drive/v3/files', queryParameters);
    final response = await get(uri, headers: headers);
    Map<String, dynamic> parsed = jsonDecode(response.body);
    try{
      String id = parsed["files"][0]["id"];
      return id;
    }catch(e){
      return null;
    }
  }

  Future<List<PojoGroup>> getDataFromDrive(String accessToken, String fileId) async {
    final headers = { 'Authorization': 'Bearer $accessToken' };
    final url = 'https://www.googleapis.com/drive/v3/files/$fileId?alt=media';
    final response = await get(url, headers: headers);
    return _jsonToGroups(response.body);
  }

  Future<String> uploadDataToDrive(String accessToken, List<PojoGroup> groups) async {
    final headers = { 'Authorization': 'Bearer $accessToken', 'Content-Type': 'application/json; charset=UTF-8'};
    final initialQueryParameters = { 'uploadType': 'resumable' };
    final Map<String, dynamic> metaData = {
      'name': "groups.json",
      'parents': ['appDataFolder']
    };
    final initiateUri = Uri.https('www.googleapis.com', '/upload/drive/v3/files', initialQueryParameters);
    final initiateResponse = await post(initiateUri, headers: headers, body: json.encode(metaData));
    final location = initiateResponse.headers['location'];

    final headers2 = { 'Authorization': 'Bearer $accessToken' };
    final uploadUri = Uri.parse(location);
    final uploadResponse = await put(uploadUri, headers: headers2, body: json.encode(groups));
    return jsonDecode(uploadResponse.body)["id"];
  }

  List<PojoGroup> _jsonToGroups(String json) {
    Iterable iter = jsonDecode(json).cast<Map<String, dynamic>>();
    List<PojoGroup> groups = iter.map<PojoGroup>((json) => PojoGroup.fromJson(json)).toList();
    return groups;
  }

}

