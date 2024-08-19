// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:f1rst/features/home/views/profile_view.dart';
import 'package:f1rst/features/home/views/settings_view.dart';
import 'package:f1rst/features/home/views/user_view.dart';
import 'package:f1rst/features/log_in/state_managers/cubit.dart';
import 'package:f1rst/features/home/state_managers/cubit.dart';
import 'package:f1rst/features/home/state_managers/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    cubit.getUser();
    cubit.homeGrids();
    loginCubit = context.read<LoginCubit>();
    super.initState();
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
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/homepage.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<UserCubit, UserState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return state.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : views[state.selectedIndex];
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...List.generate(tabs.length, (int index) {
                        return GestureDetector(
                          onTap: () {
                            cubit.changeTabIndex(index);
                            print(index);
                          },
                          child: tabs[index],
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
