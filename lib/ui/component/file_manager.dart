/*
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:matrix_gesture_mb/model/project.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager{
  static FileManager? _instance;

  FileManager._internal(){
    _instance = this;
  }

  factory FileManager() => _instance?? FileManager._internal();

  //File manager logique

  Future<String> get _directoryPath async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _file async {
    final path = await _directoryPath;
    //storage/emulated/0/<your_dir_name>
    return File('$path/project.txt');
  }

  Future<File> get _jsonFile async {
    final path = await _directoryPath;
    return File('$path/project.json');
  }

  Future<File> get _imageFile async {
    final path = await _directoryPath;
    return File('$path/cheetah_image');
  }

  Future<String> readTextFile() async {
    String fileContent = 'Cheetah Coding';

    File file = await _file;

    if (await file.exists()) {
      try {
        fileContent = await file.readAsString();
      } catch (e) {
        print(e);
      }
    }

    return fileContent;
  }

  Future<String> writeTextFile() async {
    //String text = DateFormat('h:mm:ss').format(DateTime.now());
    String text = DateTime.now() as String;

    File file = await _file;
    await file.writeAsString(text);
    return text;
  }

  Future<Map<String, dynamic>?> readJsonFile() async {
    String fileContent = 'Cheetah Coding';

    File file = await _jsonFile;

    if (await file.exists()) {
      try {
        fileContent = await file.readAsString();
        return json.decode(fileContent);
      } catch (e) {
        print(e);
      }
    }

    return null;
  }

  Future<Project> writeJsonFile() async {
    final Project user = Project();

    File file = await _jsonFile;
    await file.writeAsString(json.encode(user));
    return user;
  }

  Future<Uint8List> writeImageFile() async {
    Response response = await Client().get(
      Uri.parse(
          'https://i.pinimg.com/originals/f5/1d/08/f51d08be05919290355ac004cdd5c2d6.png'),
    );

    Uint8List bytes = response.bodyBytes;
    File file = await _imageFile;
    await file.writeAsBytes(bytes);

    print(file.path);
    print(bytes);

    return bytes;
  }

  Future<Uint8List> readImageFile() async {
    File file = await _imageFile;
    Uint8List? byteList;

    if (await file.exists()) {
      try {
        byteList = await file.readAsBytes();
      } catch (e) {
        print(e);
      }
    }

    return byteList!;
  }

  deleteImage() async {
    File file = await _imageFile;
    if (await file.exists()) {
      await file.delete();
    }
  }


}*/
