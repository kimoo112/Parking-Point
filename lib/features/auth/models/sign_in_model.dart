import '../../../core/api/end_ponits.dart';

class SignInModel {
  final String message;
  final String token;
  final String displayName;

  SignInModel(
      {required this.message, required this.token, required this.displayName});

  factory SignInModel.fromJson(Map<String, dynamic> jsonData) {
    return SignInModel(
      message: jsonData[ApiKeys.email],
      token: jsonData[ApiKeys.token],
      displayName: jsonData[ApiKeys.name],
    );
  }
}
