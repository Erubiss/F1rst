// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final VoidCallback onLogout;
  final String dialogLabel;
  final String dialogQuestion;
  final String buttonText;
  const CustomDialog({
    super.key,
    required this.onLogout,
    required this.dialogLabel,
    required this.dialogQuestion,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(dialogLabel),
      content: Text(dialogQuestion),
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
          child: Text(buttonText),
        ),
      ],
    );
  }
}
