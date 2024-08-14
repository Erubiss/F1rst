// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:f1rst/core/constants/app_colors.dart';
import 'package:f1rst/features/home/views/profile_view.dart';
import 'package:f1rst/features/home/views/settings_view.dart';
import 'package:f1rst/features/log_in/state_managers/cubit.dart';
import 'package:f1rst/features/registration/state_managers/state.dart';
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
    loginCubit = context.read<LoginCubit>();
    super.initState();
  }

  List<Widget> tabs = [
    Icon(Icons.home_outlined),
    Icon(Icons.settings),
  ];
  List<Widget> views = [
    ProfileView(),
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
            child: BlocBuilder<UserCubit, UserState>(
              bloc: cubit,
              builder: (context, state) {
                return state.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  state.email,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black,
                                        offset: Offset(2.0, 2.0),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: SizedBox(
                                        width: 75,
                                        height: 75,
                                        child: state.userImage.isEmpty
                                            ? Image.asset(
                                                'assets/images/defphoto.jpg')
                                            : Image.network(
                                                state.userImage,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => {cubit.pickImage()},
                                      child: Text('Pick Image'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              state.aboutUser,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: ctrl,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Update Info',
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                cubit.updateUserAbout(ctrl.text);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: Text("Update"),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                cubit.deleteUser(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.appRed,
                              ),
                              child: Text(
                                'Delete User ${loginCubit.state.isLoading}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            views[state.selectedIndex],
                          ],
                        ),
                      );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...List.generate(tabs.length, (int index) {
                    return GestureDetector(
                        onTap: () {
                          cubit.changeTabIndex(index);
                          print(index);
                        },
                        child: tabs[index]);
                  }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
