import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_app/core/functions/navigation.dart';
import 'package:parking_app/core/routes/routes.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/core/widgets/custom_btn.dart';
import 'package:parking_app/features/auth/cubit/auth_cubit.dart';
import 'package:parking_app/features/auth/presentation/widgets/custom_text_field.dart';

import '../widgets/custom_check_box.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Success'),
          ));
        } else if (state is SignInFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text((state.errMessage))));
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Sign Up'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  hintText: 'Name',
                  controller: context.read<AuthCubit>().signUpName,
                  icon: Icons.person,
                ),
                CustomTextField(
                  controller: context.read<AuthCubit>().signUpEmail,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email_rounded,
                ),
                CustomTextField(
                  controller: context.read<AuthCubit>().signUpPhone,
                  hintText: 'Phone',
                  keyboardType: TextInputType.phone,
                  icon: Icons.phone,
                ),
                CustomTextField(
                  controller: context.read<AuthCubit>().signUpCarNumber,
                  hintText: 'Car Number',
                  icon: Icons.car_repair,
                ),
                CustomTextField(
                  controller: context.read<AuthCubit>().signUpAge,
                  hintText: 'Age',
                  keyboardType: TextInputType.number,
                  icon: Icons.car_repair,
                ),
                CustomTextField(
                  controller: context.read<AuthCubit>().signUpPassword,
                  hintText: 'Password',
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
                CustomBtn(
                    text: 'To Register',
                    onPressed: () {
                      context.read<AuthCubit>().signUp(context);
                    }),
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
                        customNavigate(context, signInView);
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
      },
    );
  }
}
