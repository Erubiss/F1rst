// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:f1rst/features/registration/components/reg_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:f1rst/features/registration/state_managers/cubit.dart';
import 'package:f1rst/features/registration/state_managers/state.dart';

class RegBuilder extends StatelessWidget {
  const RegBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationCubit(),
      child: const Registration(),
    );
  }
}

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController pswCtrl = TextEditingController();
  final TextEditingController cnfPswCtrl = TextEditingController();
  final TextEditingController aboutCtrl = TextEditingController();
  File? _selectedImage;

  // Future<void> uploadImage() async {
  //   final status = await Permission.storage.request();
  //   if (status.isGranted) {
  //     final pickedFile =
  //         await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (pickedFile != null) {
  //       setState(() {
  //         _selectedImage = File(pickedFile.path);
  //         print('Image picked: ${_selectedImage?.path}');
  //       });
  //     }
  //   } else if (status.isDenied) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Permission to access photos is required.')),
  //     );
  //   } else if (status.isPermanentlyDenied) {
  //     print('Storage permission permanently denied.');
  //     openAppSettings();
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Permission to access photos is required.')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<RegistrationCubit>(context);

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
              title: const Text('Registration'),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/images/registration.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 211, 81, 81),
                            Color(0xFF75bfcd)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF75bfcd).withOpacity(0.4),
                            offset: const Offset(5.0, 11.0),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                          BoxShadow(
                            color: Colors.yellow.withOpacity(0.1),
                            offset: const Offset(0.4, 4.0),
                            blurRadius: 2.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            // onTap: uploadImage,
                            child: CircleAvatar(
                              radius: 60,
                              child: _selectedImage == null
                                  ? const Icon(Icons.add_a_photo, size: 40)
                                  : Image.file(_selectedImage!),
                            ),
                          ),
                          const SizedBox(height: 16),
                          RegField(
                            ctrl: emailCtrl,
                            hintText: 'Email',
                            icon: Icons.email,
                            withError: state.isEmailError,
                            errorMessage:
                                cubit.getEmailErrorMessage(emailCtrl.text),
                          ),
                          const SizedBox(height: 16),
                          RegField(
                            ctrl: phoneCtrl,
                            hintText: 'Phone Number',
                            icon: Icons.phone,
                            isPhoneNumber: true,
                            withError: state.isPhoneNumberError,
                            errorMessage:
                                cubit.getPhoneErrorMessage(phoneCtrl.text),
                          ),
                          const SizedBox(height: 16),
                          RegField(
                            ctrl: pswCtrl,
                            hintText: 'Password',
                            icon: Icons.lock,
                            obscureText: true,
                            withError: state.isPasswordError,
                            errorMessage: cubit.getPasswordErrorMessage(
                                pswCtrl.text, cnfPswCtrl.text),
                          ),
                          const SizedBox(height: 16),
                          RegField(
                            ctrl: cnfPswCtrl,
                            hintText: 'Confirm Password',
                            icon: Icons.lock,
                            obscureText: true,
                            withError: state.isPasswordError,
                            errorMessage: cubit.getPasswordErrorMessage(
                                pswCtrl.text, cnfPswCtrl.text),
                          ),
                          const SizedBox(height: 16),
                          RegField(
                            ctrl: aboutCtrl,
                            hintText: 'About You',
                            icon: Icons.info,
                            maxLines: 3,
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
                              cubit.onSubmitted(
                                email: emailCtrl.text,
                                phoneNumber: phoneCtrl.text,
                                password: pswCtrl.text,
                                confirmPassword: cnfPswCtrl.text,
                                aboutUser: aboutCtrl.text,
                                userImagePath: _selectedImage?.path ?? '',
                                context: context,
                              );
                            },
                            child: const Text('Register'),
                          ),
                        ],
                      ),
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
}
