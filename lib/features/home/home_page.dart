// ignore_for_file: prefer_const_constructors

import 'package:f1rst/core/ui_components/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:f1rst/features/home/views/profile_view.dart';
import 'package:f1rst/features/home/views/settings_view.dart';
import 'package:f1rst/features/home/views/user_view.dart';
import 'package:f1rst/features/log_in/state_managers/cubit.dart';
import 'package:f1rst/features/home/state_managers/cubit.dart';
import 'package:f1rst/features/home/state_managers/state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final cubit = UserCubit();
  late final LoginCubit loginCubit;
  final ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit.getUser();
    loginCubit = context.read<LoginCubit>();
  }

  List<Widget> tabs = [
    Icon(Icons.home_outlined),
    Icon(Icons.account_circle_rounded),
    Icon(Icons.settings),
  ];

  List<Widget> views = [
    ProfileView(),
    UserView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: BlocBuilder<UserCubit, UserState>(
          bloc: cubit,
          builder: (context, state) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/images/homepage.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  state.isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            views[state.selectedIndex],
                          ],
                        ),
                  CustomBottomBar(
                    cubit: cubit,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
