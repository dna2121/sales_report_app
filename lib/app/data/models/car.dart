import 'dart:convert';

class Car {
  String carID;
  String userID;
  String carNumber;
  DateTime timestamp;
  Car({
    required this.carID,
    required this.userID,
    required this.carNumber,
    required this.timestamp,
  });

  Car copyWith({
    String? carID,
    String? userID,
    String? carNumber,
    DateTime? timestamp,
  }) {
    return Car(
      carID: carID ?? this.carID,
      userID: userID ?? this.userID,
      carNumber: carNumber ?? this.carNumber,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'carID': carID,
      'userID': userID,
      'carNumber': carNumber,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      carID: map['carID'] ?? '',
      userID: map['userID'] ?? '',
      carNumber: map['carNumber'] ?? '',
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Car.fromJson(String source) => Car.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Car(carID: $carID, userID: $userID, carNumber: $carNumber, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Car &&
      other.carID == carID &&
      other.userID == userID &&
      other.carNumber == carNumber &&
      other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return carID.hashCode ^
      userID.hashCode ^
      carNumber.hashCode ^
      timestamp.hashCode;
  }
}
