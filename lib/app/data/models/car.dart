import 'dart:convert';

class Car {
  String carID;
  String userID;
  String carNumber;
  Car({
    required this.carID,
    required this.userID,
    required this.carNumber,
  });

  Car copyWith({
    String? carID,
    String? userID,
    String? carNumber,
  }) {
    return Car(
      carID: carID ?? this.carID,
      userID: userID ?? this.userID,
      carNumber: carNumber ?? this.carNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'carID': carID,
      'userID': userID,
      'carNumber': carNumber,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      carID: map['carID'] ?? '',
      userID: map['userID'] ?? '',
      carNumber: map['carNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Car.fromJson(String source) => Car.fromMap(json.decode(source));

  @override
  String toString() => 'Car(carID: $carID, userID: $userID, carNumber: $carNumber)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Car &&
      other.carID == carID &&
      other.userID == userID &&
      other.carNumber == carNumber;
  }

  @override
  int get hashCode => carID.hashCode ^ userID.hashCode ^ carNumber.hashCode;
}
