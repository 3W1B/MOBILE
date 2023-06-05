import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:radon_app/utils/json_file_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter binding is initialized

  group('JsonFileManager tests', () {
    late JsonFileManager jsonFileManager;

    setUp(() {
    });

    test('CRUD', () async {
      final initialData = {'user': 'asd'};
      await JsonFileManager.create(initialData);

      var data = await JsonFileManager.read('user');
      expect(data, equals(initialData));

      final updatedData = {'user': 'updatedasd'};
      await JsonFileManager.update(updatedData);

      data = await JsonFileManager.read('user');
      expect(data, equals(updatedData));

      await JsonFileManager.delete('user');
    });
  });
}
