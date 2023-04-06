import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserProfile {
  String id;
  String name;
  String email;
  List<String> role;
  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    List<String>? role,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: List<String>.from(map['role']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) => UserProfile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserProfile(id: $id, name: $name, email: $email, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserProfile &&
      other.id == id &&
      other.name == name &&
      other.email == email &&
      listEquals(other.role, role);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      role.hashCode;
  }
}
