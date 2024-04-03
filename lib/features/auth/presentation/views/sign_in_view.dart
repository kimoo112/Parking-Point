import 'package:flutter/material.dart';
import 'package:parking_app/core/functions/navigation.dart';
import 'package:parking_app/core/routes/routes.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/core/widgets/custom_btn.dart';
import 'package:parking_app/features/auth/presentation/widgets/custom_text_field.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomTextField(
              hintText: 'Email',
              icon: Icons.email_rounded,
            ),
            const CustomTextField(
              hintText: 'Mot de passe',
              icon: Icons.lock,
            ),
            const SizedBox(height: 20),
            CustomBtn(
              text: 'SignIn'.toUpperCase(),
              onPressed: () {
                customNavigate(context, homeNavbar);
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Forgot Password ?',
              style: CustomTextStyles.openSans400style16Blue,
            ),
          ],
        ));
  }
}
