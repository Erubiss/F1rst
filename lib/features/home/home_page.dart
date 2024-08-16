// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:f1rst/core/constants/app_colors.dart';
import 'package:f1rst/core/ui_components/delete_dialog.dart';
import 'package:f1rst/features/home/components/update_info_sheet.dart';
import 'package:f1rst/features/home/views/profile_view.dart';
import 'package:f1rst/features/home/views/settings_view.dart';
import 'package:f1rst/features/home/views/user_view.dart';
import 'package:f1rst/features/log_in/state_managers/cubit.dart';
import 'package:f1rst/features/home/state_managers/cubit.dart';
import 'package:f1rst/features/home/state_managers/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
    Icon(Icons.account_circle_rounded),
  ];
  List<Widget> views = [ProfileView(), SettingsView(), UserView()];

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
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes!
                                                          : null,
                                                    ),
                                                  );
                                                },
                                              ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => {cubit.pickImage()},
                                      child: Text('Pick Image'),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.blue.shade200),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(children: [
                              Text(
                                state.aboutUser,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white54,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black54,
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  aboutUserBottomSheetbar(context, cubit, ctrl);
                                },
                                child: Icon(
                                  CupertinoIcons.pen,
                                  size: 30,
                                ),
                              )
                            ]),
                            views[state.selectedIndex],
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialog(
                                          onLogout: () {
                                            cubit.deleteUser(context).then(
                                                (context) => Navigator.pop);
                                          },
                                          dialogLabel: 'Delete user?',
                                          dialogQuestion: 'Are you sure?',
                                        );
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.appRed,
                                  ),
                                  child: Text(
                                    'Delete User',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialog(
                                          onLogout: () {
                                            cubit.logOut(context);
                                          },
                                          dialogLabel: 'Log out?',
                                        );
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.appRed,
                                  ),
                                  child: Text(
                                    'Log out',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            )
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
