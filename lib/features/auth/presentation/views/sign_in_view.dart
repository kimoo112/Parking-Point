import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/core/widgets/custom_btn.dart';
import 'package:parking_app/features/auth/cubit/auth_cubit.dart';
import 'package:parking_app/features/auth/presentation/widgets/custom_text_field.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool obscureText = true;
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // List of special characters
    List<String> specialCharacters = [
      '!',
      '@',
      '#',
      '\$',
      '%',
      '^',
      '&',
      '*',
      '(',
      ')',
      '_',
      '+',
      '{',
      '}',
      '|',
      ':',
      '<',
      '>',
      '?',
      '~',
      '-'
    ];

    bool hasSpecialChar = false;
    for (var char in value.split('')) {
      if (specialCharacters.contains(char)) {
        hasSpecialChar = true;
        break;
      }
    }

    if (!hasSpecialChar) {
      return 'Password must contain at least one special character';
    }

    return null; // Password is valid
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Success'),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Sign In'),
            ),
            body: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: context.read<AuthCubit>().signInEmail,
                    hintText: 'Email',
                    icon: Icons.email_rounded,
                  ),
                  CustomTextField(
                    hintText: 'Password',
                    controller: context.read<AuthCubit>().signInPassword,
                    icon: Icons.lock,
                    obscureText: obscureText,
                    validator: validatePassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  const SizedBox(height: 20),
                  state is SignInLoading
                      ? const CircularProgressIndicator()
                      : CustomBtn(
                          text: 'SignIn'.toUpperCase(),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthCubit>().signIn(context);
                            }
                          }),
                  const SizedBox(height: 20),
                  Text(
                    'Forgot Password ?',
                    style: CustomTextStyles.openSans400style16Blue,
                  ),
                ],
              ),
            ));
      },
    );
  }
}
