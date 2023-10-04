import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/admin/views/admin_detailtx_view.dart';
import 'package:sales_report_app/app/modules/admin/views/trx_view.dart';
import 'package:sales_report_app/app/modules/admin/views/update_supplier_view.dart';
import 'package:sales_report_app/app/modules/admin/views/update_tx_view.dart';
import 'package:sales_report_app/app/modules/auth/views/forgot_password_view.dart';
import 'package:sales_report_app/app/modules/profile/views/update_profile_view.dart';
import 'package:sales_report_app/app/modules/transaction/views/detail_tx_view.dart';
import 'package:sales_report_app/app/modules/transaction/views/txlist_view.dart';

import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/admin/views/new_tx_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/auth/views/signin_view.dart';
import '../modules/auth/views/signup_view.dart';
import '../modules/cars/bindings/cars_binding.dart';
import '../modules/cars/views/cars_edit_view.dart';
import '../modules/cars/views/cars_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/transaction/bindings/transaction_binding.dart';
import '../modules/transaction/views/transaction_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SigninView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.FORGOTPASSWORD,
      page: () => const ForgotPasswordView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.CARS,
      page: () => CarsView(),
      binding: CarsBinding(),
    ),
    GetPage(
      name: _Paths.CARSEDIT,
      page: () => CarsEditView(),
      binding: CarsBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION,
      page: () => TransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.TXLIST,
      page: () => TxlistView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.DETAILTX,
      page: () => DetailTxView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN,
      page: () => const AdminView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: _Paths.UPDATESUPPLIER,
      page: () => const UpdateSupplierView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: _Paths.NEWTX,
      page: () => const NewTxView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: _Paths.ADMDETAILTX,
      page: () => const AdminDetailtxView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: _Paths.UPDATETX,
      page: () => const UpdateTxView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: _Paths.TRX,
      page: () => const TrxView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.UPDATEPROFILE,
      page: () => const UpdateProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
