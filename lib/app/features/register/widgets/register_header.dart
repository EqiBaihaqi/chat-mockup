import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:test_project/app/core/theme/app_colors.dart';
import 'package:test_project/app/core/theme/app_textstyle.dart';
import 'package:test_project/app/routes/app_pages.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 48, right: 24, left: 24, bottom: 48),
            color: AppColors.darkBackground,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
                SizedBox(height: 12),
                Text(
                  'This is The logo and company name',
                  style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
                ),
                SizedBox(height: 32),
                Text(
                  'Register new account',
                  style: AppTextStyles.h1.copyWith(color: Colors.white),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      "Already have an account? ",
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        unawaited(Get.offAndToNamed(Routes.login));
                      },
                      child: Text(
                        'Sign in',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.fgLink,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
