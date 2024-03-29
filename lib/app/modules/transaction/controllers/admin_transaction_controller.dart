import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales_report_app/app/data/repositories/transactions_repositories.dart';

import '../../../data/models/transactions.dart';
import '../../auth/controllers/auth_controller.dart';

class AdminTransactionController extends GetxController {
  final txRepo = TransactionRepository.instance;
  final AuthController authController = Get.find();
  final trxFormKey = GlobalKey<FormState>();
  final priceC = TextEditingController();
  final nameC = TextEditingController();
  final carC = TextEditingController();
  final weightC = TextEditingController();
  final dateC = TextEditingController();
  final trxidC = TextEditingController();
  final uidC = TextEditingController();

  var selectedDate = DateTime.now().obs;
  late String documentId;
  String? selectedName;
  String? selectedCarnum;
  Stream<List<String>>? carNumberStream;

  void onClose() {
    // priceC.dispose();
    // weightC.dispose();
    // nameC.dispose();
    // dateC.dispose();
    super.onClose();
  }

  void signOut() {
    authController.signOut();
  }

  Stream<QuerySnapshot<Object?>> streamTx() {
    return txRepo.txCollection.snapshots();
  }

  Stream<List<String>> streamName() {
    Query<Map<String, dynamic>> itemsRef = FirebaseFirestore.instance
        .collection('Users')
        .orderBy("name", descending: false);
    return itemsRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  Stream<List<String>> streamCarNumber(String userID) {
    Query<Map<String, dynamic>> carRef = FirebaseFirestore.instance
        .collection('Car')
        .where('userID', isEqualTo: userID);
    return carRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc['carNumber'] as String).toList();
    });
  }

  Future<String?> getUserIdFromName(String selectedName) async {
    // Get a reference to the Firestore collection
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');

    // Query the collection to find the document with the matching name
    QuerySnapshot<Object?> snapshot = await usersCollection
        .where('name', isEqualTo: selectedName)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // Retrieve the first document from the query snapshot
      QueryDocumentSnapshot<Object?> documentSnapshot = snapshot.docs[0];

      // Retrieve and return the document ID
      return documentSnapshot.id;
    }

    return null; // Return null if no matching document found
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill the filled';
    }
    return null;
  }

  String? get textEmpty {
    Get.defaultDialog(
      title: 'Gagal',
      middleText: "Tidak boleh kosong!",
      onConfirm: () {
        Get.back(); //close dialog
      },
      textConfirm: 'Okay',
    );
    return null;
  }

  String? get textEmptyUpdate {
    Get.defaultDialog(
      title: 'Gagal',
      middleText: "Lengkapi data transaksi!",
      onConfirm: () {
        Get.back(); //close dialog
      },
      textConfirm: 'Okay',
    );
    return null;
  }

  void deleteTx(String keyid) {
    DocumentReference<Object?> documentReference =
        txRepo.txCollection.doc(keyid);

    try {
      Get.defaultDialog(
        title: "Hapus Data",
        middleText: "Data dihapus?",
        onConfirm: () async {
          await documentReference.delete();
          Get.back();
          Get.back();
        },
        textConfirm: "Ya",
        textCancel: "Tidak",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Sesuatu bermasalah",
        middleText: "Gagal menghapus data.",
      );
    }
  }

  void fetchTxDoc() async {
    try {
      DocumentSnapshot snapshot =
          await txRepo.txCollection.doc(documentId).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        int price = data['price'] as int;
        String name = data['name'] as String;
        int weight = data['weight'] as int;
        Timestamp timestamp = data['date'] as Timestamp;
        String carnum = data['carNumber'] as String;
        String trxId = data['transactionID'] as String;
        String uID = data['userID'] as String;

        priceC.text = price.toString();
        selectedName = name;
        weightC.text = weight.toString();
        dateC.text = DateFormat('yyyy-MM-dd').format(timestamp.toDate());
        carC.text = carnum;
        trxidC.text = trxId;
        uidC.text = uID;
      }
    } catch (error) {
      print('Failed to fetch document data: $error');
    }
  }

  void updateTxDoc() async {
    String newName = selectedName.toString();
    int newPrice = int.parse(priceC.text);
    int newWeight = int.parse(weightC.text);
    String newCarnum = carC.text;
    DateTime tanggalBaru = DateTime.parse(dateC.text);

    String? userID = await getUserIdFromName(selectedName.toString());

    try {
      await txRepo.txCollection.doc(documentId).update({
        'name': newName,
        'price': newPrice,
        'weight': newWeight,
        'userID': userID,
        'carNumber': newCarnum,
        'date': tanggalBaru
      });

      Get.defaultDialog(
        title: 'Berhasil',
        middleText: "Data diubah.",
        onConfirm: () {
          nameC.clear();
          priceC.clear();
          weightC.clear();
          Get.back(); //close dialog
          Get.back(); //close page
          Get.back(); //close bottom sheet
        },
        textConfirm: 'Okay',
      );

      print('Document updated successfully');
    } catch (error) {
      print('Failed to update document: $error');
    }
  }

  void addNewTx() async {
    if (trxFormKey.currentState!.validate()) {
      int harga = int.parse(priceC.text);
      int berat = int.parse(weightC.text);
      DateTime tanggal = DateTime.parse(dateC.text);

      String? userID = await getUserIdFromName(selectedName.toString());

      if (userID != null) {
        await txRepo.addTx(
          Transactions(
              userID: userID,
              transactionID: txRepo.txCollection.doc().id,
              name: selectedName.toString(),
              price: harga,
              weight: berat,
              date: tanggal,
              carNumber: selectedCarnum.toString()),
        );
        Get.defaultDialog(
          title: 'Berhasil',
          middleText: "Data ditambahkan.",
          onConfirm: () {
            // priceC.clear();
            // weightC.clear();
            // dateC.clear();
            resetForm();
            Get.back(); //close dialog
            Get.back(); //close page
          },
          textConfirm: 'Okay',
        );
      }
    }
  }

  void resetForm() {
    trxFormKey.currentState?.reset();
    selectedName = null;
    selectedCarnum = null;
    selectedDate.value = DateTime.now();
  }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
      errorFormatText: "Enter valid date",
    );
    if (pickedDate != null) {
      selectedDate.value = pickedDate;
      dateC.text = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    }
  }

  void showCustomDialog() async {
    await Get.defaultDialog(
      title: "Dialog Title",
      content: Text("Dialog Content"),
      confirm: ElevatedButton(
        onPressed: () {
          // Handle the confirm button action here
          Get.back(); // Close the dialog
        },
        child: Text("Confirm"),
      ),
    );
  }
}
