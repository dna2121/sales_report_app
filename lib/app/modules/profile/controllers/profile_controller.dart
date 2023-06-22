import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/repositories/user_repositories.dart';
import '../../auth/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  final userRepo = UserRepository.instance;

  Stream<DocumentSnapshot<Object?>> getData() {
    return userRepo.userCollection
        .doc('${AuthController.instance.firebaseAuth.currentUser!.uid}')
        .snapshots();
  }
}
