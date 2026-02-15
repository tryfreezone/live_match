import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String? displayName;
  @HiveField(1)
  String? userName;
  @HiveField(2)
  String? password;
  @HiveField(3)
  String? name;
  @HiveField(4)
  String? email;
  @HiveField(5)
  String? phoneNumber;
  @HiveField(6)
  String? address;
  @HiveField(7)
  String? photoURL;
  @HiveField(8)
  bool? passwordVerified;

  UserModel({
    this.displayName,
    this.userName,
    this.password,
    this.name,
    this.email,
    this.phoneNumber,

    this.address,
    this.photoURL,
    this.passwordVerified,
  });

  factory UserModel.fromJson({
    required Map<String, dynamic> data,
    required User user,
  }) {
    try {
      return UserModel(
        displayName: data['displayName'] ?? '',
        userName: data['userName'] ?? '',
        password: data['password'] ?? '',
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        address: data['address'] ?? '',
        photoURL: data['photoURL'] ?? '',
        passwordVerified: data['passwordVerified'] ?? false,
      );
    } catch (error) {
      throw FormatException('Invalid JSON: $data');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'userName': userName,
      'password': password,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'photoURL': photoURL,
      'passwordVerified': passwordVerified,
    };
  }
}
