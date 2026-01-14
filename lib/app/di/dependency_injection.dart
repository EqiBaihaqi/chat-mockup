import 'package:get/get.dart';
import 'package:test_project/app/data/repositories/auth_repository_impl.dart';
import 'package:test_project/app/data/repositories/chat_repository_impl.dart';
import 'package:test_project/app/domain/repositories/auth_repository.dart';
import 'package:test_project/app/domain/repositories/chat_repository.dart';
import 'package:test_project/objectbox.g.dart';

Future<void> initService() async {
  // initialize objectBox store
  final store = await openStore();

  // Register store permanently
  Get.put<Store>(store, permanent: true);

  // Register repository
  Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(store), fenix: true);
  Get.lazyPut<ChatRepository>(() => ChatRepositoryImpl(store), fenix: true);

  // Seeding trigger
  await Get.find<AuthRepository>().seedDefaultUser();
}
