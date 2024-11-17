import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  const AppTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      this.validator});

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(),
            focusedBorder: const UnderlineInputBorder(),
            hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 15,
              )
          ),
        ),
      ),
    );
  }
}
