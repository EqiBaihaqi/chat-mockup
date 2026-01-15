import 'package:get/instance_manager.dart';
import 'package:test_project/app/domain/repositories/auth_repository.dart';
import 'package:test_project/app/domain/usecases/login_usecase.dart';
import 'package:test_project/app/features/login/controllers/login_controller.dart';
import 'package:test_project/app/utils/session/session_manager.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginUseCase>(() => LoginUseCase(Get.find<AuthRepository>()));
    Get.lazyPut<LoginController>(
      () =>
          LoginController(Get.find<LoginUseCase>(), Get.find<SessionManager>()),
    );
  }
}
