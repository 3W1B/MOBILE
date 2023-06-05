import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

abstract class JsonFileManager {
  static Future<File> create(Map<String, dynamic> newData) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/data.json');

    // Check if the file exists
    final fileExists = await file.exists();

    // Read the existing data from the file or use an empty Map
    Map<String, dynamic> existingData = {};
    if (fileExists) {
      try {
        final jsonData = await file.readAsString();
        existingData = jsonDecode(jsonData);
      } catch (e) {
        print("Couldn't read file");
      }
    }

    // Check if the specified tag already exists
    newData.forEach((tag, data) {
      if (existingData.containsKey(tag)) {
        throw Exception("Data with tag '$tag' already exists.");
      }
    });

    // Merge the existing data with the new data
    existingData.addAll(newData);

    // Write the updated data back to the file
    final jsonData = jsonEncode(existingData);
    return file.writeAsString(jsonData);
  }

  static Future<dynamic> read(String tag) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/data.json');

    // Check if the file exists
    final fileExists = await file.exists();

    if (!fileExists) {
      return null;
    }

    try {
      final jsonData = await file.readAsString();
      final data = jsonDecode(jsonData);
      return data[tag];
    } catch (e) {
      print("Couldn't read file");
      return null;
    }
  }

  static Future<File> update(Map<String, dynamic> updatedData) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/data.json');

    // Check if the file exists
    final fileExists = await file.exists();

    // Read the existing data from the file or use an empty Map
    Map<String, dynamic> existingData = {};
    if (fileExists) {
      try {
        final jsonData = await file.readAsString();
        existingData = jsonDecode(jsonData);
      } catch (e) {
        print("Couldn't read file");
      }
    }

    // Update the existing data with the provided updated data
    updatedData.forEach((tag, data) {
      if (existingData.containsKey(tag)) {
        existingData[tag] = data;
      }
    });

    // Write the updated data back to the file
    final jsonData = jsonEncode(existingData);
    return file.writeAsString(jsonData);
  }

  static Future<File> delete(String tag) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final file = File('$path/data.json');

    // Check if the file exists
    final fileExists = await file.exists();

    // Read the existing data from the file or use an empty Map
    Map<String, dynamic> existingData = {};
    if (fileExists) {
      try {
        final jsonData = await file.readAsString();
        existingData = jsonDecode(jsonData);
      } catch (e) {
        print("Couldn't read file");
      }
    }

    // Remove the data with the specified tag
    existingData.remove(tag);

    // Write the updated data back to the file
    final jsonData = jsonEncode(existingData);
    return file.writeAsString(jsonData);
  }
}
