import 'package:flutter/material.dart';
import 'package:parking_app/core/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final bool isHavePrefix ;
  final TextEditingController? controller;
  final IconData? icon;
  final IconData? suffixIcon;
  final Function(String)? onChanged;
  const CustomTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.icon,
    this.suffixIcon,
    this.onChanged, this.isHavePrefix= true,
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
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon:isHavePrefix? Icon(icon, color: AppColors.darkGrey):null,
          hintStyle: TextStyle(color: AppColors.darkGrey),
          hintText: hintText,
          suffixIcon: Icon(suffixIcon, color: AppColors.darkGrey),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
