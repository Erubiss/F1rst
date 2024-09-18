// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:f1rst/core/extensions.dart';
import 'package:f1rst/core/ui_components/app_button.dart';
import 'package:f1rst/core/ui_components/custom_dialog.dart';
import 'package:f1rst/features/home/components/update_info_sheet.dart';
import 'package:f1rst/features/home/state_managers/cubit.dart';
import 'package:f1rst/features/home/state_managers/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();
    final ctrl = TextEditingController();

    return BlocBuilder<UserCubit, UserState>(
      bloc: cubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              state.email,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 12.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 46),
            ClipRRect(
              borderRadius: BorderRadius.circular(75),
              child: SizedBox(
                width: 150,
                height: 150,
                child: state.userImage.isEmpty
                    ? Image.asset('assets/images/defphoto.jpeg',
                        fit: BoxFit.cover)
                    : Image.network(
                        state.userImage,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes !=
                                      null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ??
                                          1)
                                  : null,
                              backgroundColor: Colors.white,
                            ),
                          );
                        },
                      ),
              ),
            ),
            SizedBox(height: 22),
            AppButton(
              label: "Pick Image",
              labelColor: Colors.white,
              buttonColor: Colors.blue.shade400,
              onTap: () => cubit.pickImage(),
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Text(
                state.aboutUser,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  shadows: [
                    Shadow(
                      blurRadius: 12.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () =>
                  aboutUserBottomSheetbar(context, cubit, ctrl),
              child: Text(
                'Edit About Me',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade400,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
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
                            cubit
                                .deleteUser(context)
                                .then((_) => Navigator.pop(context));
                          },
                          dialogLabel: 'Delete user?',
                          dialogQuestion: 'Are you sure?',
                          buttonText: "Delete",
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    'Delete User',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialog(
                          onLogout: () => cubit.logOut(context),
                          dialogQuestion: "Log out of account?",
                          dialogLabel: 'Log out?',
                          buttonText: "Logout",
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    'Log out',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ).paddingLTRB(16, 70, 16, 16).expanded();
      },
    );
  }
}
