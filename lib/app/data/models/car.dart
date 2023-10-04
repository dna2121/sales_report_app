import 'dart:convert';

class Car {
  String carID;
  String userID;
  String carNumber;
  String name;
  Car({
    required this.carID,
    required this.userID,
    required this.carNumber,
    required this.name,
  });

  Car copyWith({
    String? carID,
    String? userID,
    String? carNumber,
    String? name,
  }) {
    return Car(
      carID: carID ?? this.carID,
      userID: userID ?? this.userID,
      carNumber: carNumber ?? this.carNumber,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'carID': carID,
      'userID': userID,
      'carNumber': carNumber,
      'name': name,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      carID: map['carID'] ?? '',
      userID: map['userID'] ?? '',
      carNumber: map['carNumber'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Car.fromJson(String source) => Car.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Car(carID: $carID, userID: $userID, carNumber: $carNumber, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Car &&
      other.carID == carID &&
      other.userID == userID &&
      other.carNumber == carNumber &&
      other.name == name;
  }

  @override
  int get hashCode {
    return carID.hashCode ^
      userID.hashCode ^
      carNumber.hashCode ^
      name.hashCode;
  }
}
