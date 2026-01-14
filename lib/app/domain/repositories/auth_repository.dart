import 'package:test_project/app/domain/entity/user.dart';

abstract class AuthRepository {
  Future<User> register(String name, String username, String password);

  Future<User?> login(String username, String password);

  Future<void> seedDefaultUser();
}
