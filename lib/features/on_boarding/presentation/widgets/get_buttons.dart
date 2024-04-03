import 'package:flutter/material.dart';
import 'package:parking_app/core/functions/navigation.dart';
import '../../../../core/utils/app_colors.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_btn.dart';
import '../../data/models/on_boarding_model.dart';

class GetButtons extends StatelessWidget {
  const GetButtons(
      {super.key, required this.currentIndex, required this.controller});
  final int currentIndex;
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    if (currentIndex == onBoardingData.length - 1) {
      return CustomBtn(
        text: AppStrings.createAccount,
        onPressed: () {
          customReplacementNavigate(context, '/signUpView');
        },
      );
    } else {
      return Column(
        children: [
          CustomBtn(
            text: AppStrings.next,
            onPressed: () {
              controller.nextPage(
                duration: const Duration(milliseconds: 444),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            },
          ),
          CustomBtn(
            textColor: AppColors.primaryColor,
            color: AppColors.grey,
            text: AppStrings.jump,
            onPressed: () {
              controller.jumpToPage(
                2,
              );
            },
          ),
        ],
      );
    }
  }
}
