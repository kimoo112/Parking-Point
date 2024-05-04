import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_app/core/functions/navigation.dart';
import 'package:parking_app/core/routes/routes.dart';
import 'package:parking_app/core/utils/app_text_styles.dart';
import 'package:parking_app/core/widgets/custom_btn.dart';
import 'package:parking_app/features/auth/cubit/auth_cubit.dart';
import 'package:parking_app/features/auth/presentation/widgets/custom_text_field.dart';

import '../widgets/custom_check_box.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
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
                      icon: Icons.numbers_sharp,
                    ),
                    CustomTextField(
                      controller: context.read<AuthCubit>().signUpPassword,
                      hintText: 'Password',
                      validator: validatePassword,
                      obscureText: obscureText,
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
                    state is SignUpLoading
                        ? const CircularProgressIndicator()
                        : CustomBtn(
                            text: 'To Register',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthCubit>().signUp(context);
                              }
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
                                                customReplacementNavigate(context, signInView);

                          },
                          child: Text(
                            style: CustomTextStyles.openSans400style16Blue,
                            "Sign In",
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}
