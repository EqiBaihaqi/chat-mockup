import 'package:test_project/app/domain/entity/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;
  LoginUseCase(this._repository);

  Future<User?> execute(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      return null;
    }
    return await _repository.login(username, password);
  }
}
