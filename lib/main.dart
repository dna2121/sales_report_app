import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/bindings/app_binding.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(SalesReport());
}

class SalesReport extends StatelessWidget {
  const SalesReport({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Krub',
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 24),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
            selectedItemColor: const Color.fromRGBO(136, 164, 124, 1),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromRGBO(136, 164, 124, 1))),
      initialBinding: AppBinding(),
    );
  }
}
