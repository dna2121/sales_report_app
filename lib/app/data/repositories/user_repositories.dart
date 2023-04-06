import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_report_app/app/data/models/user_profile.dart';

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
}