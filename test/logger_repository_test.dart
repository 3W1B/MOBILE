import 'package:flutter_test/flutter_test.dart';
import 'package:radon_app/repositories/logger_repository.dart';

void main() {
  group('Logger Repository', () {
    test("Test should return a logger", () async {
      LoggerRepository loggerRepository = LoggerRepository();
      final logger = await loggerRepository.read('testid', 'testpassword');
      expect(logger.id, 'testid');
    });
  });
}