import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Transactions {
  String userID;
  String transactionID;
  String name;
  int price;
  String? carNumber;
  int weight;
  DateTime? date;
  Transactions({
    required this.userID,
    required this.transactionID,
    required this.name,
    required this.price,
    this.carNumber,
    required this.weight,
    this.date,
  });

  Transactions copyWith({
    String? userID,
    String? transactionID,
    String? name,
    int? price,
    String? carNumber,
    int? weight,
    DateTime? date,
  }) {
    return Transactions(
      userID: userID ?? this.userID,
      transactionID: transactionID ?? this.transactionID,
      name: name ?? this.name,
      price: price ?? this.price,
      carNumber: carNumber ?? this.carNumber,
      weight: weight ?? this.weight,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'transactionID': transactionID,
      'name': name,
      'price': price,
      'carNumber': carNumber,
      'weight': weight,
      'date': Timestamp.fromDate(date!),
    };
  }

  factory Transactions.fromMap(Map<String, dynamic> map) {
    return Transactions(
      userID: map['userID'] ?? '',
      transactionID: map['transactionID'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toInt() ?? 0,
      carNumber: map['carNumber'],
      weight: map['weight']?.toInt() ?? 0,
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transactions.fromJson(String source) =>
      Transactions.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Transactions(userID: $userID, transactionID: $transactionID, name: $name, price: $price, carNumber: $carNumber, weight: $weight, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transactions &&
        other.userID == userID &&
        other.transactionID == transactionID &&
        other.name == name &&
        other.price == price &&
        other.carNumber == carNumber &&
        other.weight == weight &&
        other.date == date;
  }

  @override
  int get hashCode {
    return userID.hashCode ^
        transactionID.hashCode ^
        name.hashCode ^
        price.hashCode ^
        carNumber.hashCode ^
        weight.hashCode ^
        date.hashCode;
  }
}
