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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        textTheme: TextTheme(
            bodyMedium: TextStyle(color: AppColor.body),
            bodyLarge:
                TextStyle(color: AppColor.title, fontWeight: FontWeight.w500)),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          actionsIconTheme: IconThemeData(color: AppColor.iconColor),
          toolbarHeight: 100,
          titleTextStyle: TextStyle(
              color: AppColor.title, fontSize: 22, fontFamily: 'Poppins'),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColor.body,
          showUnselectedLabels: false,
          unselectedIconTheme: IconThemeData(color: Colors.grey),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: Colors.white, backgroundColor: AppColor.green),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: AppColor.button,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
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
        dialogBackgroundColor: AppColor.background,
      ),
      initialBinding: AppBinding(),
    );
  }
}
