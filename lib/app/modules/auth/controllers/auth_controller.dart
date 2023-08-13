import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sales_report_app/app/data/models/user_profile.dart';
import 'package:sales_report_app/app/data/repositories/user_repositories.dart';

import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final firebaseAuth = FirebaseAuth.instance;
  final userRepo = UserRepository.instance;

  late Rx<User?> firebaseUser;
  late Rx<UserProfile?> userProfile;
  String? userId;

  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rx<User?>(firebaseAuth.currentUser);
    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    await Future.delayed(const Duration(seconds: 2));
    //nobody has logged in yet, == null
    if (user == null) {
      Get.offAllNamed(Routes.SIGNIN);
    } else {
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void signIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      Get.showSnackbar(const GetSnackBar(
        title: 'Success',
        message: 'Sign in success',
        duration: Duration(seconds: 3),
      ));
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: e.toString(),
        duration: Duration(seconds: 3),
      ));
    }
  }

  void signOut() {
    firebaseAuth.signOut();
  }

  void signUp(String email, String password, String name, String phoneNumber,
      String address) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      var newUser = firebaseAuth.currentUser; //untuk dapat uid account

      if (newUser == null) {
        // Jika pengguna tidak berhasil dibuat, munculkan pesan peringatan
        Get.showSnackbar(GetSnackBar(
          title: 'Error',
          message: 'Failed to create user. Please try again later.',
          duration: Duration(seconds: 3),
        ));
        return;
      }

      newUser.updateDisplayName(name);

      userRepo.addUser(UserProfile(
          id: newUser.uid,
          email: email,
          name: name,
          role: ['user'],
          phoneNumber: phoneNumber,
          address: address));

      Get.showSnackbar(const GetSnackBar(
        title: 'Success',
        message: 'Sign up success',
        duration: Duration(seconds: 2),
      ));
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          // Jika email sudah digunakan
          Get.showSnackbar(GetSnackBar(
            title: 'Error',
            message: 'Email already in use. Please use a different email.',
            duration: Duration(seconds: 3),
          ));
        } else if (e.code == 'invalid-email') {
          // Jika email tidak valid
          Get.showSnackbar(GetSnackBar(
            title: 'Error',
            message: 'Invalid email. Please use a valid email address.',
            duration: Duration(seconds: 3),
          ));
        } else {
          // lainnya
          Get.showSnackbar(GetSnackBar(
            title: 'Error',
            message: 'Something went wrong. Please try again later.',
            duration: Duration(seconds: 3),
          ));
        }
      } else {
        // Jika terjadi error yang tidak terkait dengan Firebase Authentication
        Get.showSnackbar(GetSnackBar(
          title: 'Error',
          message: e.toString(),
          duration: Duration(seconds: 3),
        ));
      }
    }
  }
}

  // late bool isEmailVerified;

  // Check if the user's email is verified
      // bool isEmailVerified = user.emailVerified;
      // if (isEmailVerified) {
      //   Get.offAllNamed(Routes.HOME);
      // } else {
      //   Get.offAllNamed(Routes.VERIFYEMAIL);
      // }

// Future sendVerificationEmail() async {
  //   final user = firebaseAuth.currentUser!;
  //   await user.sendEmailVerification();
  // }

  // Future checkEmailVerified() async {
  //   await firebaseAuth.currentUser!.reload();

  //   isEmailVerified = firebaseAuth.currentUser!.emailVerified;
  // }