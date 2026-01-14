import 'package:objectbox/objectbox.dart';
import 'package:test_project/app/data/models/user_model.dart';
import 'package:test_project/app/domain/entity/user.dart';
import 'package:test_project/app/domain/repositories/auth_repository.dart';
import 'package:test_project/objectbox.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  // We inject the Store (Database) via constructor
  AuthRepositoryImpl(Store store) : _userBox = store.box<UserModel>();
  final Box<UserModel> _userBox;

  @override
  Future<User?> login(String username, String password) async {
    // Find user with the match username and password
    final query = _userBox
        .query(
          UserModel_.username.equals(username) &
              UserModel_.password.equals(password),
        )
        .build();

    final UserModel? userModel = query.findFirst();
    query.close();

    // Map to entity
    if (userModel == null) return null;
    return userModel.toEntity();
  }

  @override
  Future<User> register(String name, String username, String password) async {
    // Check if the username already taken
    final query = _userBox.query(UserModel_.username.equals(username)).build();
    final existingUser = query.findFirst();
    query.close();
    if (existingUser != null) {
      throw Exception('Username $username is already taken.');
    }

    // Create model
    final newUserModel = UserModel(
      name: name,
      username: username,
      password: password,
    );

    // Save to db
    final id = _userBox.put(newUserModel);

    // Return entitiy with the new id
    // Update the id since 'put' assign it
    newUserModel.id = id;
    return newUserModel.toEntity();
  }

  @override
  Future<dynamic> seedDefaultUser() async {
    // Seed data only when the db is empty
    if (_userBox.isEmpty()) {
      final users = [
        UserModel(
          name: 'Testing satu',
          username: 'test1',
          password: 'password123',
        ),
        UserModel(
          name: 'Testing dua',
          username: 'test2',
          password: 'password123',
        ),
      ];
      _userBox.putMany(users);
    }
  }
}
