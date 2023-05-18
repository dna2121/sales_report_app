import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_report_app/app/data/models/user_profile.dart';
import 'package:sales_report_app/app/modules/auth/controllers/auth_controller.dart';

class UserRepository {
  UserRepository._();

  static UserRepository get instance {
    return UserRepository._();
  }

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  addUser(UserProfile userProfile) async {
    await userCollection.doc(userProfile.id).set(userProfile.toMap());
  }

  void addCars(String carNumber) async {
    await userCollection
        .doc('${AuthController.instance.firebaseAuth.currentUser!.uid}')
        .collection("Cars")
        .add({"carNumber": carNumber, "timestamps": Timestamp.now()});
  }
}
