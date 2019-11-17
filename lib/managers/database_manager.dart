import 'dart:convert';
import 'dart:io';

import 'package:dusza2019/resources/pojos/pojo_group.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  static final Database _singleton = Database._internal();

  factory Database() {
    return _singleton;
  }

  Database._internal();

  Future<List<PojoGroup>> getGroups() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/groups.json');
      if (!file.existsSync()) file.createSync();

      print("Groups loaded!");
      String json = await file.readAsString();
      if (json.isEmpty) json = "[]";

      return _jsonToGroups(json);
    } catch (e) {
      print("Couldn't read file " + e.toString());
    }
    return new List();
  }

  Future<void> saveGroups(List<PojoGroup> groups) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/groups.json');
    final text = jsonEncode(groups);
    await file.writeAsString(text);
    print('Groups saved!');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("DBLastUpdated", DateTime.now().toIso8601String());
  }

  Future<void> syncWithGoogleDrive(String accessToken) async {
    String fileId = await _getDBFileIdFromDrive(accessToken);
    if (fileId == null) {
      print("Groups not found on drive... Uploading now!");
      fileId =
          await Database()._uploadGroupsToDrive(accessToken, await getGroups());
      return;
    }

    print("Groups found on drive!");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastUpdatedString = prefs.getString("DBLastUpdated");
    DateTime lastUpdatedLocally = lastUpdatedString == null
        ? DateTime(1999)
        : DateTime.parse(lastUpdatedString);
    DateTime lastUpdatedDrive =
        await _getLastChangedDateDrive(accessToken, fileId);
    if (lastUpdatedLocally.isAfter(lastUpdatedDrive)) {
      print("Google drive is behind... updating");
      await _updateGroupsOnDrive(accessToken, fileId, await getGroups());
    } else {
      print("Local is behind... updating");
      await saveGroups(await _getGroupsFromDrive(accessToken, fileId));
    }
    prefs.setString("GDriveLastSync", DateTime.now().toIso8601String());
  }

  Future<String> _getDBFileIdFromDrive(String accessToken) async {
    final Map<String, String> queryParameters = {
      'spaces': 'appDataFolder',
      'q': 'name = "groups.json"',
    };
    final headers = {'Authorization': 'Bearer $accessToken'};
    final uri =
        Uri.https('www.googleapis.com', '/drive/v3/files', queryParameters);
    final response = await get(uri, headers: headers);
    Map<String, dynamic> parsed = jsonDecode(response.body);
    try {
      String id = parsed["files"][0]["id"];
      return id;
    } catch (e) {
      return null;
    }
  }

  Future<DateTime> _getLastChangedDateDrive(
      String accessToken, String fileId) async {
    final headers = {'Authorization': 'Bearer $accessToken'};
    final url =
        'https://www.googleapis.com/drive/v3/files/$fileId?fields=modifiedTime';
    final response = await get(url, headers: headers);
    DateTime time = DateTime.parse(jsonDecode(response.body)["modifiedTime"]);
    return time;
  }

  Future<List<PojoGroup>> _getGroupsFromDrive(
      String accessToken, String fileId) async {
    final headers = {'Authorization': 'Bearer $accessToken'};
    final url = 'https://www.googleapis.com/drive/v3/files/$fileId?alt=media';
    final response = await get(url, headers: headers);
    return _jsonToGroups(utf8.decode(response.bodyBytes));
  }

  Future<String> _uploadGroupsToDrive(
      String accessToken, List<PojoGroup> groups) async {
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final initialQueryParameters = {'uploadType': 'resumable'};
    final Map<String, dynamic> metaData = {
      'name': "groups.json",
      'parents': ['appDataFolder']
    };
    final initiateUri = Uri.https(
        'www.googleapis.com', '/upload/drive/v3/files', initialQueryParameters);
    final initiateResponse =
        await post(initiateUri, headers: headers, body: json.encode(metaData));
    final location = initiateResponse.headers['location'];

    final headers2 = {'Authorization': 'Bearer $accessToken'};
    final uploadUri = Uri.parse(location);
    final uploadResponse =
        await put(uploadUri, headers: headers2, body: json.encode(groups));
    return jsonDecode(uploadResponse.body)["id"];
  }

  Future<void> _updateGroupsOnDrive(
      String accessToken, String fileId, List<PojoGroup> groups) async {
    final headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final initiateUri =
        Uri.https('www.googleapis.com', '/upload/drive/v3/files/$fileId');
    await patch(initiateUri, headers: headers, body: json.encode(groups));
  }

  List<PojoGroup> _jsonToGroups(String json) {
    Iterable iterator = jsonDecode(json).cast<Map<String, dynamic>>();
    List<PojoGroup> groups =
        iterator.map<PojoGroup>((json) => PojoGroup.fromJson(json)).toList();
    return groups;
  }
}
