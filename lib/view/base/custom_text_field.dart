import 'dart:ffi';

import 'package:flutter/material.dart';
import '../../helper/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData? icon;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.icon,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: AppColors.buttonPrimary),
      enabled: enabled,
      cursorColor: AppColors.buttonPrimary,
      decoration: InputDecoration(
        prefixIcon: icon != null
            ? Icon(icon, color: AppColors.buttonPrimary)
            : null,

        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.buttonPrimary),

        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.buttonPrimary),
        ),

        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.buttonPrimary, width: 2),
        ),
      ),
    );
  }
}
