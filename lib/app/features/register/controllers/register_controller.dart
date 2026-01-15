import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/domain/usecases/register_usecase.dart';
import 'package:test_project/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  RegisterController(this._registerUsecase);
  final RegisterUsecase _registerUsecase;

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoadingRegister = false.obs;

  var errorMessageRegister = ''.obs;

  RxBool isHidePassword = true.obs;

  void isHidePasswordToggle() => isHidePassword.toggle();

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
      await _registerUsecase.excecute(
        nameController.text,
        usernameController.text,
        passwordController.text,
      );

      Get.showSnackbar(
        GetSnackBar(
          title: 'Success',
          message: 'New account registered!',
          duration: Duration(seconds: 2),
        ),
      );
      unawaited(Get.toNamed(Routes.login));

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

  @override
  void onClose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
