import 'package:test_project/app/domain/entity/user.dart';
import 'package:test_project/app/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  RegisterUsecase(this._authRepository);
  final AuthRepository _authRepository;

  Future<User> excecute(String name, String username, String password) async {
    if (password.length < 8) {
      throw Exception('Password must be at least 8 character');
    }
    return await _authRepository.register(name, username, password);
  }
}
