import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales_report_app/utils/color.dart';

import 'app/bindings/app_binding.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBP6R-El-rAwuhMs3KHkdefrhgn6XxZA-k",
          appId: "1:244691395214:web:6b734d65e706a32f8a5fdf",
          messagingSenderId: "244691395214",
          projectId: "sales-report-app-cb6ca"));

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
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(foregroundColor: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: AppColor.fabBtn,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
        cardTheme: CardTheme(
          // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          color: Colors.transparent,
          elevation: 0,
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        drawerTheme: DrawerThemeData(backgroundColor: Colors.grey.shade200),
        dialogBackgroundColor: Colors.white,
      ),
      initialBinding: AppBinding(),
    );
  }
}
