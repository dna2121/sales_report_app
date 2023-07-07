import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/utils/color.dart';

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
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 24),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColor.grey,
          selectedItemColor: AppColor.green,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: Colors.white, backgroundColor: AppColor.green),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: AppColor.hijau,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        cardTheme: CardTheme(
          margin: EdgeInsets.symmetric(horizontal: 11, vertical: 9),
          color: AppColor.background,
          elevation: 0,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(13)),
        ),
        drawerTheme: DrawerThemeData(backgroundColor: Colors.grey.shade200),
      ),
      initialBinding: AppBinding(),
    );
  }
}
