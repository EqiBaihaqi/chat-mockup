import 'package:test_project/app/domain/entity/user.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UserModel {
  UserModel({
    this.id = 0,
    required this.name,
    required this.username,
    required this.password,
  });

  @Id()
  int id;

  @Unique()
  String name;
  String username;
  String password;

  // Mapper: model -> entity
  User toEntity() {
    return User(id: id, name: name, username: username, password: password);
  }

  // Mapper : entity -> model
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      username: user.username,
      password: user.password,
    );
  }
}
