import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/repositories/user_repositories.dart';
import '../../auth/controllers/auth_controller.dart';

class HomeController extends GetxController {
  var tabIndex = 0.obs;
  final userRepo = UserRepository.instance;

  void changeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }

  Stream<DocumentSnapshot<Object?>> getRole() {
    return userRepo.userCollection
        .doc('${AuthController.instance.firebaseAuth.currentUser!.uid}')
        .snapshots();
  }
}
