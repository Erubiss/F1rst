import 'package:f1rst/features/log_in/state_managers/cubit.dart';
import 'package:f1rst/features/registration/state_managers/cubit.dart';
import 'package:f1rst/features/home/state_managers/cubit.dart';
import 'package:f1rst/features/home/home_page.dart';

import 'package:f1rst/views/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegistrationCubit(),
        ),
        BlocProvider(
          create: (context) => UserCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        home: auth.currentUser == null ? SplashScreen() : HomePage(),
        // home: SplashScreen(),
      ),
    );
  }
}
