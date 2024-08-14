// ignore_for_file: prefer_const_constructors

import 'package:equatable/equatable.dart';
import 'package:f1rst/models/user_model.dart';

class RegistrationState extends Equatable {
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final String aboutUser;
  final String userImage;
  final bool isLoading;
  final bool isEmailError;
  final bool isPhoneNumberError;
  final bool isPasswordError;
  final String emailMessage;
  final String phoneNumberMessage;
  final String passwordMessage;
  final UserModel user;

  const RegistrationState({
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    required this.aboutUser,
    required this.userImage,
    required this.isLoading,
    required this.isEmailError,
    required this.isPhoneNumberError,
    required this.isPasswordError,
    required this.emailMessage,
    required this.phoneNumberMessage,
    required this.passwordMessage,
    required this.user,
  });

  RegistrationState copyWith({
    String? email,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
    String? aboutUser,
    String? userImage,
    bool? isLoading,
    bool? isEmailError,
    bool? isPhoneNumberError,
    bool? isPasswordError,
    String? emailMessage,
    String? phoneNumberMessage,
    String? passwordMessage,
    UserModel? user,
  }) {
    return RegistrationState(
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      aboutUser: aboutUser ?? this.aboutUser,
      userImage: userImage ?? this.userImage,
      isLoading: isLoading ?? this.isLoading,
      isEmailError: isEmailError ?? this.isEmailError,
      isPhoneNumberError: isPhoneNumberError ?? this.isPhoneNumberError,
      isPasswordError: isPasswordError ?? this.isPasswordError,
      emailMessage: emailMessage ?? this.emailMessage,
      phoneNumberMessage: phoneNumberMessage ?? this.phoneNumberMessage,
      passwordMessage: passwordMessage ?? this.passwordMessage,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        email,
        phoneNumber,
        password,
        confirmPassword,
        aboutUser,
        userImage,
        isLoading,
        isEmailError,
        isPhoneNumberError,
        isPasswordError,
        emailMessage,
        phoneNumberMessage,
        passwordMessage,
        user,
      ];

  factory RegistrationState.initial() {
    return RegistrationState(
      email: "",
      phoneNumber: "",
      password: "",
      confirmPassword: "",
      aboutUser: "",
      userImage: "assets/imagesdefphoto.jpg",
      isLoading: false,
      isEmailError: false,
      isPhoneNumberError: false,
      isPasswordError: false,
      emailMessage: '',
      phoneNumberMessage: '',
      passwordMessage: '',
      user: UserModel(
        aboutUser: '',
        uid: '',
        phoneNumber: '',
        email: '',
        userImage: '',
      ),
    );
  }
}
