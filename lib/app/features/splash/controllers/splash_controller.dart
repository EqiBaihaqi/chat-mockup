import 'dart:async';

import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:test_project/app/routes/app_pages.dart';
import 'package:test_project/app/utils/session/session_manager.dart';

class SplashController extends GetxController {
  SplashController(this._session);
  final SessionManager _session;

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  void checkLogin() async {
    await Future.delayed(const Duration(seconds: 3));

    if (_session.isLoggedIn()) {
      Get.offAllNamed(Routes.chatDashboard);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}
