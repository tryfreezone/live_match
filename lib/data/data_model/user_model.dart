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
  @HiveField(9)
  String? uid;
  @HiveField(10)
  String? userType;
  @HiveField(11)
  String? age;
  @HiveField(12)
  String? location;
  @HiveField(13)
  String? favoriteSport;
  @HiveField(14)
  bool? profileComplete;

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
    this.uid, 
    this.userType,
    this.age,
    this.location,
    this.favoriteSport,
    this.profileComplete,
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
        uid: data['uid'] ?? user.uid,
        userType: data['userType'] ?? '',
        age: data['age']?.toString(),
        location: data['location'] ?? '',
        favoriteSport: data['favoriteSport'] ?? '',
        profileComplete: data['profileComplete'] ?? false,
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
      'uid': uid,
      'userType': userType,
      'age': age,
      'location': location,
      'favoriteSport': favoriteSport,
      'profileComplete': profileComplete,
    };
  }
} 
