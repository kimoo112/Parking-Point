import 'package:flutter/material.dart';
import 'package:parking_app/core/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final bool isHavePrefix;
  final TextEditingController? controller;
  final IconData? icon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? obscureText ;
  const CustomTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.obscureText,
    this.icon,
    this.suffixIcon,
    this.onChanged,
    this.isHavePrefix = true,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        keyboardType: keyboardType,
        controller: controller,
        validator: validator ??
            (value) {
              if (value!.isEmpty) {
                return 'field is required';
              }

              return null;
            },
        decoration: InputDecoration(
          prefixIcon:
              isHavePrefix ? Icon(icon, color: AppColors.darkGrey) : null,
          hintStyle: TextStyle(color: AppColors.darkGrey),
          hintText: hintText,
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
