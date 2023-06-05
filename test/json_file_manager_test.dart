import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:radon_app/utils/json_file_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter binding is initialized

  group('JsonFileManager tests', () {
    late JsonFileManager jsonFileManager;

    setUp(() {
      jsonFileManager = JsonFileManager();
    });

    test('CRUD', () async {
      final initialData = {'user': 'asd'};
      await jsonFileManager.create(initialData);

      var data = await jsonFileManager.read('user');
      expect(data, equals(initialData));

      final updatedData = {'user': 'updatedasd'};
      await jsonFileManager.update(updatedData);

      data = await jsonFileManager.read('user');
      expect(data, equals(updatedData));

      await jsonFileManager.delete('user');
    });
  });
}
