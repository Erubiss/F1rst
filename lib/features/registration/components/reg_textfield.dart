import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final int maxLines;
  final TextEditingController ctrl;
  final bool withError;
  final String errorMessage;
  final bool isPhoneNumber;

  const RegField({
    super.key,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.maxLines = 1,
    required this.ctrl,
    this.withError = false,
    this.errorMessage = '',
    this.isPhoneNumber = false,
  });

  @override
  State<RegField> createState() => _RegFieldState();
}

class _RegFieldState extends State<RegField> {
  final maskFormatter = MaskTextInputFormatter(
    mask: '+### (##) ##-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          inputFormatters: widget.isPhoneNumber ? [maskFormatter] : [],
          controller: widget.ctrl,
          obscureText: widget.obscureText,
          maxLines: widget.maxLines,
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
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
          ),
        ),
        if (widget.withError)
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 9.0),
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
