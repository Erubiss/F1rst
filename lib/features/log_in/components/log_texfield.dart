
import 'package:flutter/material.dart';

class LogField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController ctrl;
  final bool withError;
  final String errorMessage;

  const LogField({
    super.key,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    required this.ctrl,
    this.withError = false,
    this.errorMessage = '',
  });

  @override
  State<LogField> createState() => _LogFieldState();
}

class _LogFieldState extends State<LogField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.ctrl,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: Icon(widget.icon),
            filled: true,
            fillColor: Colors.grey[200],
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 2.0,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
          ),
        ),
        if (widget.withError)
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8),
              child: Text(
                widget.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
      ],
    );
  }
}
