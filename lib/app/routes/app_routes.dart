part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const login = _Paths.login;
  static const register = _Paths.register;
  static const chatDashboard = _Paths.chat_dashboard;
}

abstract class _Paths {
  _Paths._();
  static const login = '/login';
  static const register = '/register';
  static const chat_dashboard = '/chat-dashboard';
}
