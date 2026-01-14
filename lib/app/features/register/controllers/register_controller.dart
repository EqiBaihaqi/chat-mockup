import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_project/app/domain/usecases/register_usecase.dart';
import 'package:test_project/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  RegisterController(this._registerUsecase);
  final RegisterUsecase _registerUsecase;

  final _storage = GetStorage();

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoadingRegister = false.obs;

  var errorMessageRegister = ''.obs;

  Future<void> register() async {
    errorMessageRegister.value = '';

    if (nameController.text.isEmpty ||
        usernameController.text.isEmpty ||
        passwordController.text.isEmpty) {
      errorMessageRegister.value = 'Please fill the required fields';
      return;
    }

    if (usernameController.text.length < 3) {
      errorMessageRegister.value = 'Username must be at least 3 characters';
      return;
    }

    if (passwordController.text.length < 8) {
      errorMessageRegister.value = 'Password must be at least 8 characters';
      return;
    }

    isLoadingRegister.value = true;

    try {
      final newUser = await _registerUsecase.excecute(
        nameController.text,
        usernameController.text,
        passwordController.text,
      );

      // After succeded register new account, it will directly go to home page (auto login)
      _storage.write('current_user_id', newUser.id);

      unawaited(Get.toNamed(Routes.chatDashboard));

      print('yahur2');
    } catch (e) {
      if (e.toString().toLowerCase().contains('already taken')) {
        errorMessageRegister.value = 'Username is already taken';
      } else {
        errorMessageRegister.value = 'Unexpected error : $e';
      }
    } finally {
      isLoadingRegister.value = false;
    }
  }
}
