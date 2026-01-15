import 'package:get/instance_manager.dart';
import 'package:test_project/app/features/splash/controllers/splash_controller.dart';
import 'package:test_project/app/utils/session/session_manager.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController(Get.find<SessionManager>()));
  }
}
