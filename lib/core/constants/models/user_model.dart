import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String email;
  final String phoneNumber;
  final String aboutUser;
  final String uid;
  final String userImage;

  UserModel({
    required this.email,
    required this.phoneNumber,
    required this.aboutUser,
    required this.uid,
    required this.userImage,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      aboutUser: map['aboutUser'] ?? '',
      uid: map['uid'] ?? '',
      userImage: map['userImage'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        email,
        phoneNumber,
        aboutUser,
        uid,
        userImage,
      ];
}
