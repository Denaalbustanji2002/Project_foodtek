import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

abstract class UserState {}


class InitialState extends UserState {}


class UserLoadingLogin extends UserState {}
class LoginSuccessState extends UserState {
  final UserModel userModel;
  LoginSuccessState({required this.userModel});
}
class LoginFailedState extends UserState {
  final String errorMessage;
  LoginFailedState({required this.errorMessage});
}


class UserLoadingSignUp extends UserState {}
class SignUpSuccessState extends UserState {
  final String successMessage;
  SignUpSuccessState({required this.successMessage});
}
class SignUpFailedState extends UserState {
  final String errorMessage;
  SignUpFailedState({required this.errorMessage});
}

class UserLoadingLogout extends UserState {}
class LogoutSuccessState extends UserState {}
class LogoutFailedState extends UserState {
  final String errorMessage;
  LogoutFailedState({required this.errorMessage});
}

class UserLoadingGoogleSignIn extends UserState {}
class GoogleSignInSuccessState extends UserState {
  final UserCredential userCredential;
  GoogleSignInSuccessState({required this.userCredential});
}
class GoogleSignInFailedState extends UserState {
  final String errorMessage;
  GoogleSignInFailedState({required this.errorMessage});
}

class UserLoadingState extends UserState {}
class UserLoggedInState extends UserState {}
class UserNotLoggedInState extends UserState {}

class UserLoadingResetPassword extends UserState {}
class ResetPasswordSuccessState extends UserState {

}
class ResetPasswordFailedState extends UserState {
  final String errorMessage;
  ResetPasswordFailedState({required this.errorMessage});
}

class ForgotPasswordLoadingState extends UserState {}
class ForgotPasswordSuccessState extends UserState {
  final String message;
  ForgotPasswordSuccessState({required this.message});
}
class ForgotPasswordFailedState extends UserState {
  final String error;
  ForgotPasswordFailedState({required this.error});
}

class UserLoadingOtpVerificationState extends UserState {}
class VerifyOtpSuccessState extends UserState {}
class VerifyOtpFailedState extends UserState {
  final String errorMessage;
  VerifyOtpFailedState({required this.errorMessage});
}
