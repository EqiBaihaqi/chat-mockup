import 'package:get/get.dart';
import 'package:test_project/app/domain/repositories/auth_repository.dart';
import 'package:test_project/app/domain/usecases/register_usecase.dart';
import 'package:test_project/app/features/register/controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterUsecase(Get.find<AuthRepository>()));

    Get.lazyPut(() => RegisterController(Get.find<RegisterUsecase>()));
  }
}
