import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:radon_app/repositories/user_logger_repository.dart';
import 'package:radon_app/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('User Repository', () {

    final uuid = const Uuid().v4();

    int userId = 0;

    test("Test should register a user", () async {
      UserRepository userRepository = UserRepository();
      final user = await userRepository.register(
          uuid, 'testpassword', 'testfirst', 'testlast', uuid
      );
      expect(user.email, uuid);
      userId = user.id;
    });

    test("Test should login a user", () async {
      UserRepository userRepository = UserRepository();
      final user = await userRepository.login(uuid, 'testpassword');
      expect(user.email, uuid);
    });

    // we also need to test the userlogger repository here, otherwise it's hard
    // to test the userlogger repository without a user
    test("Test should create a userlogger", () async {
      UserLoggerRepository userRepository = UserLoggerRepository();
      final userLogger = await userRepository.create(userId, 'testid', 'testpassword');
      expect(userLogger.userId, userId);
      expect(userLogger.loggerId, 'testid');
    });
  });
}