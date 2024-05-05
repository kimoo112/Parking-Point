import 'end_ponits.dart';

class ErrorModel {
  final int status;
  final String errorMessage;
  final List<String?> errors;

  ErrorModel({required this.errors,required this.status, required this.errorMessage});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      errors: jsonData['errors'],
      status: jsonData[ApiKeys.status],
      errorMessage: jsonData[ApiKeys.errorMessage],
    );
  }
}
