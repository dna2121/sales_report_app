import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserProfile {
  String id;
  String? name;
  String? email;
  List<String> role;
  String? phoneNumber;
  String? address;
  UserProfile({
    required this.id,
    this.name,
    this.email,
    required this.role,
    this.phoneNumber,
    this.address,
  });

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    List<String>? role,
    String? phoneNumber,
    String? address,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] ?? '',
      name: map['name'],
      email: map['email'] ?? '',
      role: List<String>.from(map['role']),
      phoneNumber: map['phoneNumber'],
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserProfile(id: $id, name: $name, email: $email, role: $role, phoneNumber: $phoneNumber, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserProfile &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        listEquals(other.role, role) &&
        other.phoneNumber == phoneNumber &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        role.hashCode ^
        phoneNumber.hashCode ^
        address.hashCode;
  }
}
