import 'package:get/get.dart';
import 'package:test_project/app/features/login/bindings/login_binding.dart';
import 'package:test_project/app/features/login/views/login_view.dart';
import 'package:test_project/app/features/register/bindings/register_binding.dart';
import 'package:test_project/app/features/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.login;

  static final routes = [
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
  ];
}
