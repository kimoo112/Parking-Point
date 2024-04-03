import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    Key? key,
    this.color,
    required this.text,
    this.onPressed,
    this.marginSize,
    this.textColor,
  }) : super(key: key);

  final Color? color;
  final String text;
  final Color? textColor;
  final VoidCallback? onPressed;
  final double? marginSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(55),
      child: Container(
        margin: EdgeInsets.all(marginSize ?? 8),
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(55),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: CustomTextStyles.openSans400style16Grey.copyWith(
            fontSize: 18,
            color: textColor ?? AppColors.offWhite,
          ),
        ),
      ),
    );
  }
}
