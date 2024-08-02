import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscure;
  final TextEditingController controller;
  final String errorText;

  MyTextField({
    super.key,
    required this.hintText,
    required this.obscure,
    required this.controller,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            obscureText: obscure,
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              fillColor: Theme.of(context).colorScheme.secondary,
              filled: true,
              hintText: hintText,
              hintStyle:
                  TextStyle(color: Theme.of(context).colorScheme.primary),
              errorText: errorText.isEmpty ? null : errorText,
              errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
