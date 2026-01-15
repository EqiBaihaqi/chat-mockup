import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_project/app/di/dependency_injection.dart';
import 'package:test_project/app/routes/app_pages.dart';

import 'app/utils/session/session_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initService();
  await GetStorage.init(SessionKey.session);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.white)),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
