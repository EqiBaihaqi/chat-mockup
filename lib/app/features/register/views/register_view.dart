import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/app/core/theme/app_colors.dart';
import 'package:test_project/app/core/theme/app_textstyle.dart';
import 'package:test_project/app/core/widgets/custom_primary_button.dart';
import 'package:test_project/app/core/widgets/custom_textfield.dart';
import 'package:test_project/app/features/register/widgets/register_header.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RegisterHeader(),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name', style: AppTextStyles.bodyMedium),
                CustomTextField(
                  hintText: 'Name',
                  controller: controller.nameController,
                ),
                SizedBox(height: 16),
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
                    onTapViewPassword: () => controller.isHidePasswordToggle(),
                  ),
                ),
                SizedBox(height: 12),
                Obx(() {
                  if (controller.errorMessageRegister.value.isEmpty) {
                    return SizedBox.shrink();
                  } else {
                    return Text(
                      controller.errorMessageRegister.value,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.error,
                      ),
                    );
                  }
                }),
                SizedBox(height: 16),
                Obx(
                  () => CustomPrimaryButton(
                    text: 'Register',
                    backgroundColor: AppColors.blueBold,
                    isLoading: controller.isLoadingRegister.value,
                    onPressed: () => controller.register(),
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
