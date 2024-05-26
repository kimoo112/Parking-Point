import 'package:flutter/material.dart';
import 'package:parking_app/core/utils/app_assets.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/core/widgets/custom_btn.dart';
import 'package:parking_app/features/auth/presentation/widgets/custom_text_field.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.canPop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Forgot your password',
          style: CustomTextStyles.openSansBoldStyle24,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(Assets.imagesForgerPassword),
            Text(
              'Select the contact information you want to use to reset your password.',
              style: CustomTextStyles.openSans700style16Black,
            ),
            const SizedBox(height: 20),
            const CustomTextField(
              hintText: 'Email',
              isHavePrefix: false,
            ),
            const Spacer(),
            const CustomBtn(text: 'Continue')
          ],
        ),
      ),
    );
  }
}
