import 'package:get/get.dart';
import 'package:sales_report_app/app/modules/home/views/transaction_view.dart';

import '../modules/supplier/views/update_supplier_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/forgot_password_view.dart';
import '../modules/auth/views/signin_view.dart';
import '../modules/auth/views/signup_view.dart';
import '../modules/cars/bindings/cars_binding.dart';
import '../modules/cars/views/cars_edit_view.dart';
import '../modules/cars/views/cars_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile/views/update_profile_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/supplier/bindings/supplier_binding.dart';
import '../modules/supplier/views/supplier_view.dart';
import '../modules/transaction/bindings/transaction_binding.dart';
import '../modules/transaction/views/admin_transaction_view.dart';
import '../modules/transaction/views/create_transaction_view.dart';
import '../modules/transaction/views/detail_tx_view.dart';
import '../modules/transaction/views/update_transaction_view.dart';
import '../modules/transaction/views/user_transaction_view.dart';
import '../modules/transaction/views/user_txlist_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
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
      name: _Paths.USERTRANSACTION,
      page: () => UserTransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.USERTXLIST,
      page: () => UserTxlistView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.DETAILTX,
      page: () => DetailTxView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.CREATETRANSACTION,
      page: () => const CreateTransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.UPDATETRANSACTION,
      page: () => const UpdateTransactionView(),
      binding: TransactionBinding(),
    ),
    GetPage(
      name: _Paths.ADMINTRANSACTION,
      page: () => const AdminTransactionView(),
      binding: TransactionBinding(),
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
    GetPage(
      name: _Paths.SUPPLIER,
      page: () => SupplierView(),
      binding: SupplierBinding(),
    ),
    GetPage(
      name: _Paths.UPDATESUPPLIER,
      page: () => const UpdateSupplierView(),
      binding: TransactionBinding(),
    ),
  ];
}
