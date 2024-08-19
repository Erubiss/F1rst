// ignore_for_file: avoid_print, prefer_const_constructors, unnecessary_this

import 'dart:io';
import 'package:f1rst/core/constants/models/user_model.dart';
import 'package:f1rst/features/registration/state_managers/state.dart';
import 'package:f1rst/features/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RegistrationCubit() : super(RegistrationState.initial());
  void onSubmitted({
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required String userImagePath,
    required BuildContext context,
    String aboutUser = "",
    String userImage = '',
  }) async {
    validateEmail(email);
    validatePhoneNumber(phoneNumber);
    validatePasswords(password, confirmPassword);

    if (state.isEmailError ||
        state.isPhoneNumberError ||
        state.isPasswordError) {
      return;
    }

    try {
      emit(state.copyWith(isLoading: true));

      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (auth.currentUser == null) {
        throw Exception('User creation failed: auth.currentUser is null');
      }

      print('User created: ${auth.currentUser!.uid}');

      final imageUrl = await _uploadUserImage(userImagePath);

      await firestore.collection('users').doc(auth.currentUser!.uid).set({
        'email': email,
        'phoneNumber': phoneNumber,
        'aboutUser': aboutUser,
        'userImage': userImage == '' ? state.userImage : imageUrl,
      }).then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });

      print('User data saved to Firestore');
//.then
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(state.copyWith(emailMessage: 'This email is already registered.'));
      } else {
        emit(state.copyWith(emailMessage: 'An error occurred: ${e.message}'));
      }
      print('FirebaseAuthException: ${e.code}');
    } catch (e) {
      emit(state.copyWith(emailMessage: 'An unexpected error occurred.'));
      print('Unexpected error: $e');
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void getUser() async {
    try {
      emit(state.copyWith(isLoading: true));
      if (auth.currentUser == null) return;
      final res =
          await firestore.collection('users').doc(auth.currentUser!.uid).get();

      if (res.data() != null) {
        final UserModel user = UserModel.fromMap(res.data()!);
        emit(
          state.copyWith(
            user: user,
          ),
        );
        print(state.user);
      }
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      print(e);
    }
  }

  Future<String> _uploadUserImage(String filePath) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_images/${DateTime.now().toIso8601String()}');
    final uploadTask = storageRef.putFile(File(filePath));

    final snapshot = await uploadTask.whenComplete(() => {});
    return await snapshot.ref.getDownloadURL();
  }

  void validateEmail(String email) {
    final errorMessage = getEmailErrorMessage(email);
    emit(state.copyWith(
      emailMessage: errorMessage,
      isEmailError: errorMessage.isNotEmpty,
    ));
  }

  void validatePhoneNumber(String phoneNumber) {
    final errorMessage = getPhoneErrorMessage(phoneNumber);
    emit(state.copyWith(
      phoneNumberMessage: errorMessage,
      isPhoneNumberError: errorMessage.isNotEmpty,
    ));
  }

  void validatePasswords(String password, String confirmPassword) {
    final errorMessage = getPasswordErrorMessage(password, confirmPassword);
    emit(state.copyWith(
      passwordMessage: errorMessage,
      isPasswordError: errorMessage.isNotEmpty,
    ));
  }

  String getPasswordErrorMessage(String password, String confirmPassword) {
    if (password.isEmpty || confirmPassword.isEmpty) {
      return 'Password fields cannot be empty';
    }
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    if (password.length < 6) {
      return 'Password is too short';
    }
    return '';
  }

  String getEmailErrorMessage(String email) {
    switch (email.getEmailValidationState()) {
      case EmailValidationState.empty:
        return 'The email is empty';
      case EmailValidationState.invalid:
        return 'Incorrect email';
      case EmailValidationState.valid:
        return '';
    }
  }

  String getPhoneErrorMessage(String phone) {
    switch (phone.getPhoneValidationState()) {
      case PhoneNumberValidationState.empty:
        return 'Please fill your phone number';
      case PhoneNumberValidationState.notFull:
        return 'Invalid number';
      case PhoneNumberValidationState.valid:
        return '';
    }
  }
}

String getPasswordErrorMessage(String password, String confirmPassword) {
  if (password.isEmpty || confirmPassword.isEmpty) {
    return 'Password fields cannot be empty';
  }
  if (password != confirmPassword) {
    return 'Passwords do not match';
  }
  if (password.length < 6) {
    return 'Password is too short';
  }
  return '';
}

extension EmailValidation on String {
  EmailValidationState getEmailValidationState() {
    if (this.isEmpty) {
      return EmailValidationState.empty;
    }
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(this)) {
      return EmailValidationState.invalid;
    }
    return EmailValidationState.valid;
  }
}

extension PhoneNumberValidation on String {
  PhoneNumberValidationState getPhoneValidationState() {
    if (this.isEmpty) {
      return PhoneNumberValidationState.empty;
    }
    if (this.length < 10) {
      return PhoneNumberValidationState.notFull;
    }
    return PhoneNumberValidationState.valid;
  }
}

enum EmailValidationState {
  empty,
  invalid,
  valid,
}

enum PhoneNumberValidationState {
  empty,
  notFull,
  valid,
}

enum PasswordValidationState {
  empty,
  notMatching,
  invalid,
  valid,
}
