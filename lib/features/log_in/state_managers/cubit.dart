import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f1rst/features/log_in/state_managers/state.dart';
import 'package:f1rst/features/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  LoginCubit() : super(LoginState.initial());

  void logIn(String email, String password, BuildContext context) async {
    validateEmail(email);
    validatePassword(password);

    if (state.isEmailError || state.isPasswordError) {
      return;
    }

    try {
      final res = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(res);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(state.copyWith(emailMessage: 'This email is already registered.'));
      } else if (e.code == 'weak-password') {
        emit(state.copyWith(passwordMessage: 'The password is too weak.'));
      }
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void validateEmail(String email) {
    final errorMessage = getEmailErrorMessage(email);
    emit(state.copyWith(
      emailMessage: errorMessage,
      isEmailError: errorMessage.isNotEmpty,
    ));
  }

  void validatePassword(String password) {
    final errorMessage = getPasswordErrorMessage(password);
    emit(state.copyWith(
      passwordMessage: errorMessage,
      isPasswordError: errorMessage.isNotEmpty,
    ));
  }

  String getPasswordErrorMessage(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
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

enum EmailValidationState {
  empty,
  invalid,
  valid,
}
