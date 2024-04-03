import 'package:flutter/material.dart';
import 'package:parking_app/core/functions/navigation.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/core/widgets/custom_btn.dart';
import 'package:parking_app/features/auth/presentation/widgets/custom_text_field.dart';

import '../widgets/custom_check_box.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomTextField(
              hintText: 'Name',
              icon: Icons.person,
            ),
             const CustomTextField(
              hintText: 'Email',
              icon: Icons.email_rounded,
            ),
            const CustomTextField(
              hintText: 'Password',
              icon: Icons.lock,
            ),
              const CustomTextField(
              hintText: 'Confirm Password',
              icon: Icons.lock,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomCheckBox(),
                Text(
                  'Remember Me',
                  style: CustomTextStyles.openSans400style16Blue,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const CustomBtn(text: 'To Register'),
            const SizedBox(height: 20),
         
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Already have an account?',
                  style: CustomTextStyles.openSans400style14Grey,
                ),
                TextButton(
                  onPressed: () {
                    customNavigate(context, '/signInView');
                  },
                  child: Text(
                    style: CustomTextStyles.openSans400style16Blue,
                    "Sign In",
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
