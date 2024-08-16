// ignore_for_file: prefer_const_constructors

import 'package:f1rst/features/home/state_managers/cubit.dart';
import 'package:flutter/material.dart';

void showDeleteDialog(BuildContext context, UserCubit cubit) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete Profile'),
        content: Text('Are you sure?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              cubit.deleteUser(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text('Delete'),
          ),
        ],
      );
    },
  );
}
