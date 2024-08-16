// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final VoidCallback onLogout;
  final String dialogLabel;
  final String? dialogQuestion;
  const CustomDialog({
    super.key,
    required this.onLogout,
    required this.dialogLabel,
    this.dialogQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(dialogLabel),
      content: Text(dialogQuestion ?? 'joj'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: onLogout,
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
          child: Text('Delete'),
        ),
      ],
    );
  }
}
