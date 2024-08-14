import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isLoading;
  final bool isEmailError;
  final bool isPasswordError;
  final String emailMessage;
  final String passwordMessage;

  const LoginState({
    required this.email,
    required this.password,
    required this.isLoading,
    required this.isEmailError,
    required this.isPasswordError,
    required this.emailMessage,
    required this.passwordMessage,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? isEmailError,
    bool? isPasswordError,
    String? emailMessage,
    String? passwordMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isEmailError: isEmailError ?? this.isEmailError,
      isPasswordError: isPasswordError ?? this.isPasswordError,
      emailMessage: emailMessage ?? this.emailMessage,
      passwordMessage: passwordMessage ?? this.passwordMessage,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        isLoading,
        isEmailError,
        isPasswordError,
        emailMessage,
        passwordMessage,
      ];

  factory LoginState.initial() {
    return const LoginState(
      email: "",
      password: "",
      isLoading: false,
      isEmailError: false,
      isPasswordError: false,
      emailMessage: '',
      passwordMessage: '',
    );
  }
}
