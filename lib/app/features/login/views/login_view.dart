import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/core/theme/app_colors.dart';
import 'package:test_project/app/core/theme/app_textstyle.dart';
import 'package:test_project/app/core/widgets/custom_primary_button.dart';
import 'package:test_project/app/core/widgets/custom_textfield.dart';
import 'package:test_project/app/features/login/controllers/login_controller.dart';
import 'package:test_project/app/features/login/widgets/login_header.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LoginHeader(),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Username', style: AppTextStyles.bodyMedium),
                CustomTextField(
                  hintText: 'Username',
                  controller: controller.usernameController,
                ),
                SizedBox(height: 16),
                Text('Password', style: AppTextStyles.bodyMedium),
                Obx(
                  () => CustomTextField(
                    hintText: 'Password',
                    controller: controller.passwordController,
                    isPassword: true,
                    isHidePassword: controller.isHidePassword.value,
                    onTapViewPassword: () => controller.toggleIsHidePassword(),
                  ),
                ),
                SizedBox(height: 12),
                Obx(() {
                  if (controller.errorMessageLogin.value.isEmpty) {
                    return SizedBox.shrink();
                  } else {
                    return Text(
                      controller.errorMessageLogin.value,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.error,
                      ),
                    );
                  }
                }),
                SizedBox(height: 16),
                Obx(
                  () => CustomPrimaryButton(
                    text: 'Login',
                    backgroundColor: AppColors.blueBold,
                    isLoading: controller.isLoading.value,
                    onPressed: () => controller.login(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
