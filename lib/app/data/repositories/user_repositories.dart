import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_report_app/app/data/models/car.dart';
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

  editUser(UserProfile userProfile) async {
    await userCollection.doc(userProfile.id).update(userProfile.toMap());
  }

  //MOBIL MOBILAN
  CollectionReference carCollection =
      FirebaseFirestore.instance.collection('Car');

  addTruck(Car car) async {
    await carCollection.doc(car.carID).set(car.toMap());
  }

  editTruck(Car car) async {
    await userCollection.doc(car.carID).update(car.toMap());
  }
}
