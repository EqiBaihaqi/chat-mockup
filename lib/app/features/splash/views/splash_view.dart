import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:test_project/app/constant/constant_assets.dart';
import 'package:test_project/app/features/splash/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset(ConstantAssets.logo)));
  }
}
