// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Color labelColor;
  final Color buttonColor;
  final double height;
  final VoidCallback onTap;

  const AppButton({
    Key? key,
    required this.label,
    required this.labelColor,
    required this.buttonColor,
    this.height = 56,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: 120,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(20)),
        child: Text(
          label,
          style: TextStyle(
            color: labelColor,
          ),
        ),
      ),
    );
  }
}
