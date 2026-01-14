import 'package:get/get.dart';
import 'package:test_project/app/features/chat_dahsboard/bindings/chat_dashboard_binding.dart';
import 'package:test_project/app/features/chat_dahsboard/views/chat_dashboard_view.dart';
import 'package:test_project/app/features/login/bindings/login_binding.dart';
import 'package:test_project/app/features/login/views/login_view.dart';
import 'package:test_project/app/features/register/bindings/register_binding.dart';
import 'package:test_project/app/features/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.login;

  static final routes = [
    GetPage(name: _Paths.login, page: LoginView.new, binding: LoginBinding()),
    GetPage(
      name: _Paths.register,
      page: RegisterView.new,
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.chat_dashboard,
      page: ChatDashboardView.new,
      binding: ChatDashboardBinding(),
    ),
  ];
}
