part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class SignUpLoading extends AuthState {}

final class SignUpSuccess extends AuthState {}

final class SignUpFailure extends AuthState {
  final String errMessage;

  SignUpFailure({required this.errMessage});
}

final class GetCarNumberSuccessfully extends AuthState {}
final class GetCarNumberLoading extends AuthState {}
final class GetCarNumberFailure extends AuthState {}

final class SignInLoading extends AuthState {}

final class SignInSuccess extends AuthState {}

final class SignInFailure extends AuthState {
  final String errMessage;

  SignInFailure({required this.errMessage});
}

final class ProfileImageEmpty extends AuthState {}
final class ProfileImageLoading extends AuthState {}

final class ProfileImagePicked extends AuthState {
  final String imagePath;

  ProfileImagePicked({required this.imagePath});
}
