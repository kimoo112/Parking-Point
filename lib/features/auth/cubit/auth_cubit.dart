import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../core/api/api_consumer.dart';
import '../../../core/api/end_ponits.dart';
import '../../../core/cache/cache_helper.dart';
import '../models/sign_in_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.api) : super(AuthInitial());
  final ApiConsumer api;
  String carNumber = '';
  TextEditingController signUpName = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpAge = TextEditingController();
  TextEditingController signUpPhone = TextEditingController();
  TextEditingController signUpCarNumber = TextEditingController();
  TextEditingController signInEmail = TextEditingController();
  TextEditingController signInPassword = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  signUp(context) async {
    emit(SignUpLoading());
    try {
      final response = await api.post(
        '${EndPoint.baseUrl}${EndPoint.register}',
        data: {
          ApiKeys.name: signUpName.text,
          ApiKeys.age: signUpAge.text,
          ApiKeys.carNumber: signUpCarNumber.text,
          ApiKeys.phone: signUpPhone.text,
          ApiKeys.email: signUpEmail.text,
          ApiKeys.password: signUpPassword.text
        },
      );

      emit(SignUpSuccess());
      signUpName.clear();
    } catch (e) {
      debugPrint(e.toString());
      emit(SignUpFailure(errMessage: "Check The Fields Again "));
    }
  }

  signIn(context) async {
    emit(SignInLoading());
    try {
      final response =
          await api.post('${EndPoint.baseUrl}${EndPoint.signIn}', data: {
        ApiKeys.email: signInEmail.text,
        ApiKeys.password: signInPassword.text,
      });
      final user = SignInModel.fromJson(response);
      await CacheHelper().saveData(key: ApiKeys.token, value: user.token);
      emit(SignInSuccess());
      CacheHelper().saveData(key: ApiKeys.email, value: user.email);
      CacheHelper().saveData(key: ApiKeys.name, value: user.displayName);
      debugPrint(response.data);
    } catch (e) {
      emit(SignInFailure(errMessage: "Check The Fields Again "));
    }
  }

  getCarNumber() async {
    final response =
        await api.get('${EndPoint.baseUrl}${EndPoint.carNumber}', headers: {
      'Token': 'Bearer ${CacheHelper().getData(key: ApiKeys.token)}',
    });
  }
}
