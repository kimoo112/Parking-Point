import '../../../core/api/end_ponits.dart';

class SignInModel {
  final String email;
  final String token;
  final String displayName;

  SignInModel(
      {required this.email, required this.token, required this.displayName});

  factory SignInModel.fromJson(Map<String, dynamic> jsonData) {
    return SignInModel(
      email: jsonData[ApiKeys.email],
      token: jsonData[ApiKeys.token],
      displayName: jsonData[ApiKeys.name],
    );
  }
}
