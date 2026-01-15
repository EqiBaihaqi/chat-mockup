import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_project/app/domain/usecases/login_usecase.dart';
import 'package:test_project/app/routes/app_pages.dart';
import 'package:test_project/app/utils/session/session_key.dart';
import 'package:test_project/app/utils/session/session_manager.dart';

class LoginController extends GetxController {
  LoginController(this._loginUseCase, this._sessionManager);
  final LoginUseCase _loginUseCase;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final errorMessageLogin = ''.obs;

  RxBool isLoading = false.obs;

  RxBool isHidePassword = true.obs;
  void toggleIsHidePassword() => isHidePassword.toggle();

  final SessionManager _sessionManager;

  Future<void> login() async {
    errorMessageLogin.value = '';
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      errorMessageLogin.value = 'Please fill the username and password field';
      return;
    }

    isLoading.value = true;
    try {
      final user = await _loginUseCase.execute(
        usernameController.text,
        passwordController.text,
      );

      if (user != null) {
        // save the cureent user id
        _sessionManager.write(SessionKey.currentUserId, user.id);

        // Navigate to Home
        unawaited(Get.offAllNamed(Routes.chatDashboard));

        print('yahur');
      } else {
        errorMessageLogin.value = 'Incorrect username or password';
      }
    } catch (e) {
      errorMessageLogin.value = 'Unexpected error $e';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
