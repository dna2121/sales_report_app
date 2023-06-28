import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/repositories/user_repositories.dart';

class SupplierController extends GetxController {
  final userRepo = UserRepository.instance;

  Stream<QuerySnapshot<Object?>> getUser() {
    return userRepo.userCollection.orderBy("name").snapshots();
  }
}
