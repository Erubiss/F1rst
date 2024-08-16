import 'package:f1rst/features/log_in/components/log_texfield.dart';
import 'package:f1rst/features/log_in/state_managers/cubit.dart';
import 'package:f1rst/features/log_in/state_managers/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final cubit = context.read<LoginCubit>();
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text('Log in'),
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/images/log_in.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: _fieldDecoration(),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LogField(
                              ctrl: emailCtrl,
                              hintText: 'Email',
                              icon: Icons.email,
                              withError: state.isEmailError,
                              errorMessage: state.emailMessage,
                            ),
                            const SizedBox(height: 16),
                            LogField(
                              ctrl: passwordCtrl,
                              hintText: 'Password',
                              icon: Icons.lock,
                              obscureText: true,
                              withError: state.isPasswordError,
                              errorMessage: state.passwordMessage,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                overlayColor: Colors.blue,
                              ),
                              onPressed: () {
                                cubit.logIn(
                                    emailCtrl.text, passwordCtrl.text, context);
                              },
                              child: const Text('Log In'),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _fieldDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.8),
      borderRadius: BorderRadius.circular(30),
      gradient: const LinearGradient(
        colors: [Color.fromARGB(255, 211, 81, 81), Color(0xFF75bfcd)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF75bfcd).withOpacity(0.4),
          offset: const Offset(
            5.0,
            11.0,
          ),
          blurRadius: 10.0,
          spreadRadius: 2.0,
        ),
        BoxShadow(
          color: Colors.yellow.withOpacity(0.1),
          offset: const Offset(
            0.4,
            4.0,
          ),
          blurRadius: 2.0,
          spreadRadius: 1.0,
        ),
      ],
    );
  }
}
