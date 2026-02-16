// GENERATED MANUALLY: Hive TypeAdapter for UserModel
// This replaces the usual build_runner-generated file.

part of 'user_model.dart';

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return UserModel(
      displayName: fields[0] as String?,
      userName: fields[1] as String?,
      password: fields[2] as String?,
      name: fields[3] as String?,
      email: fields[4] as String?,
      phoneNumber: fields[5] as String?,
      address: fields[6] as String?,
      photoURL: fields[7] as String?,
      passwordVerified: fields[8] as bool?,
      uid: fields[9] as String?,
      userType: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.displayName)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.phoneNumber)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.photoURL)
      ..writeByte(8)
      ..write(obj.passwordVerified)
      ..writeByte(9)
      ..write(obj.uid)
      ..writeByte(10)
      ..write(obj.userType);
  }

  @override
  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
