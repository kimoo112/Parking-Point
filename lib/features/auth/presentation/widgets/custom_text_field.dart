import 'package:flutter/material.dart';
import 'package:parking_app/core/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final IconData? icon;
  final IconData? suffIcon;
final Function(String)? onChanged;
  const CustomTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.icon,
    this.suffIcon,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        onChanged:onChanged ,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon,color: AppColors.darkGrey),
          hintStyle: TextStyle(color: AppColors.darkGrey),
          hintText: hintText,
          suffixIcon: Icon(suffIcon,color: AppColors.darkGrey),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
