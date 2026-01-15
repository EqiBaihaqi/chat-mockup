part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const login = _Paths.login;
  static const register = _Paths.register;
  static const chatDashboard = _Paths.chatDashboard;
  static const chat = _Paths.chat;
  static const splash = _Paths.splash;
}

abstract class _Paths {
  _Paths._();
  static const login = '/login';
  static const register = '/register';
  static const chatDashboard = '/chat-dashboard';
  static const chat = '/chat';
  static const splash = '/splash';
}
