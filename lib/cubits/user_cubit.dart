import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/const_values.dart';
import '../core/validation.dart';
import '../helper/secure_storage_helper.dart';
import '../models/user_model.dart';
import '../states/user_state.dart';
import 'package:bloc/bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(InitialState());

  Validation validation = Validation();

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
    String? phoneNumber,
    required String dateOfBirth,
  }) async {
    emit(UserLoadingSignUp());

    try {
      dateOfBirth = DateFormat(
        "yyyy-MM-dd",
      ).format(DateFormat("dd/MM/yyyy").parseStrict(dateOfBirth));
    } catch (e) {
      emit(
        SignUpFailedState(
          errorMessage: "The date format is incorrect, use DD/MM/YYYY.",
        ),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('${ConstValues.baseUrl}/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': fullName,
          'email': email,
          'password': password,
          'phone_number': phoneNumber,
          'dob': dateOfBirth,
        }),
      );

      dynamic responseBody = jsonDecode(response.body);

      if (responseBody is List && responseBody.isNotEmpty) {
        responseBody = responseBody[0];
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        String message = 'Registration successful';
        if (responseBody is Map && responseBody.containsKey('data')) {
          final data = responseBody['data'];
          if (data is Map && data.containsKey('message')) {
            message = data['message'] ?? message;
          }
        }
        emit(SignUpSuccessState(successMessage: message));
      } else {
        String errorMessage = 'Registration Failed';
        if (responseBody is Map && responseBody.containsKey('message')) {
          errorMessage = responseBody['message'] ?? errorMessage;
        }
        emit(SignUpFailedState(errorMessage: errorMessage));
      }
    } catch (e) {
      emit(
        SignUpFailedState(
          errorMessage: 'Something Went Wrong :  ${e.toString()}',
        ),
      );
    }
  }

  Future<void> logIn({
    required String email,
    required String password,
    required bool remember,
  }) async {
    emit(UserLoadingLogin());

    try {
      final response = await http.post(
        Uri.parse('${ConstValues.baseUrl}/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 202) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success' &&
            responseData['data'] != null &&
            responseData['data'].isNotEmpty) {
          final data = responseData['data'][0];

          if (data['token'] == null) {
            emit(
              LoginFailedState(
                errorMessage: 'Invalid response from server. Token missing.',
              ),
            );
            return;
          }

          await SecureStorageHelper.instance.savePrefString(
            key: "token",
            value: data['token'],
          );

          if (remember) {
            await saveInfo(
              email: email,
              password: password,
              remember: remember,
            );
          }

          emit(LoginSuccessState(userModel: UserModel.fromJson(data)));
        } else {
          emit(
            LoginFailedState(
              errorMessage: 'Invalid response structure from server.',
            ),
          );
        }
      } else if (response.statusCode == 401) {
        emit(LoginFailedState(errorMessage: 'Invalid credentials.'));
      } else if (response.statusCode >= 500) {
        emit(
          LoginFailedState(
            errorMessage: 'Server error. Please try again later.',
          ),
        );
      } else {
        emit(
          LoginFailedState(
            errorMessage: 'Login failed. Status code: ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      emit(LoginFailedState(errorMessage: 'Network error occurred: $e'));
    }
  }

  Future<void> saveInfo({
    required String email,
    required String password,
    required bool remember,
  }) async {
    await SecureStorageHelper.instance.savePrefBool(
      key: "rememberMe",
      value: remember,
    );

    if (remember) {
      await SecureStorageHelper.instance.savePrefString(
        key: "email",
        value: email,
      );
      await SecureStorageHelper.instance.savePrefString(
        key: "password",
        value: password,
      );
    } else {
      await SecureStorageHelper.instance.remove(key: "email");
      await SecureStorageHelper.instance.remove(key: "password");
    }
  }

  Future<void> readInfo() async {
    try {
      validation.rememberMe = await SecureStorageHelper.instance.getPrefBool(
        key: "rememberMe",
        defaultValue: false,
      );

      if (validation.rememberMe) {
        validation.savedEmail = await SecureStorageHelper.instance
            .getPrefString(key: "email", defaultValue: "");
        validation.savedPassword = await SecureStorageHelper.instance
            .getPrefString(key: "password", defaultValue: "");
      }
    } catch (e) {}
  }

  Future<void> logOut() async {
    emit(UserLoadingLogout());
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await SecureStorageHelper.instance.remove(key: "token");
      emit(LogoutSuccessState());
    } catch (e) {
      emit(
        LogoutFailedState(errorMessage: "Failed to logout, please try again."),
      );
    }
  }

  Future<void> signInWithGoogle() async {
    emit(UserLoadingGoogleSignIn());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(GoogleSignInFailedState(errorMessage: 'Google sign-in aborted'));
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.idToken == null || googleAuth.accessToken == null) {
        emit(
          GoogleSignInFailedState(errorMessage: 'Invalid Google credentials'),
        );
        return;
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      emit(GoogleSignInSuccessState(userCredential: userCredential));
    } catch (e) {
      emit(GoogleSignInFailedState(errorMessage: 'Error occurred: $e'));
    }
  }

  Future<void> storeVerificationCode(String code) async {
    await SecureStorageHelper.instance.savePrefString(
      key: "verification_code",
      value: code,
    );
  }

  Future<String?> getStoredVerificationCode() async {
    return await SecureStorageHelper.instance.getPrefString(
      key: 'verification_code',
      defaultValue: '',
    );
  }

  Future<void> forgotPasswordResetLink(String email) async {
    emit(ForgotPasswordLoadingState());
    try {
      if (!RegExp(
        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
      ).hasMatch(email)) {
        emit(
          ForgotPasswordFailedState(
            error: 'Please enter a valid email address.',
          ),
        );
        return;
      }

      if (email.isNotEmpty) {
        final response = await http.get(
          Uri.parse('${ConstValues.baseUrl}/reset_password?email=$email'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            // 'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          await SecureStorageHelper.instance.savePrefString(
            key: "email",
            value: email,
          );
          print('Email stored successfully in secure storage: ${email}');
          final data = jsonDecode(response.body);
          print('Password reset link sent: $data');
          emit(
            ForgotPasswordSuccessState(
              message: 'Password reset link sent to email!',
            ),
          );
        } else {
          print('Failed to send password reset link: ${response.body}');
          emit(
            ForgotPasswordFailedState(
              error: 'Failed to send password reset link. Please try again.',
            ),
          );
        }
      } else {
        emit(
          ForgotPasswordFailedState(
            error: 'Please enter a valid email address.',
          ),
        );
      }
    } catch (e) {
      emit(
        ForgotPasswordFailedState(
          error: 'An error occurred. Please try again later.',
        ),
      );
    }
  }

  Future<void> verifyOtp(String email, String otp) async {
    emit(UserLoadingState());
    try {
      const String url =
          "https://foodtek-main-ognlf5.laravel.cloud/api/verify-reset-otp";
      final Map<String, String> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
      final Map<String, dynamic> body = {"email": email, "otp": otp};

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        await SecureStorageHelper.instance.getPrefString(
          key: "email",
          defaultValue: email,
        );
        await SecureStorageHelper.instance.savePrefString(
          key: "otp",
          value: otp,
        );
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == "success" &&
            responseData.containsKey('data')) {
          emit(VerifyOtpSuccessState());
        } else {
          emit(
            VerifyOtpFailedState(
              errorMessage:
                  responseData['message'] ?? "Invalid OTP, please try again.",
            ),
          );
        }
      } else {
        emit(
          VerifyOtpFailedState(
            errorMessage:
                "Server error: ${response.statusCode}, please try again later.",
          ),
        );
      }
    } catch (e) {
      emit(VerifyOtpFailedState(errorMessage: "An error occurred: $e"));
    }
  }

  Future<void> resetPassword(
    String email,
    String otp,
    String password,
    String passwordConfirmation,
  ) async {
    emit(UserLoadingResetPassword());

    try {
      final Map<String, String> headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
      final String email = await SecureStorageHelper.instance.getPrefString(
        key: "email",
        defaultValue: "",
      );
      final String otp = await SecureStorageHelper.instance.getPrefString(
        key: "otp",
        defaultValue: "",
      );

      if (email.isEmpty || otp.isEmpty) {
        return;
      }

      final Map<String, dynamic> body = {
        'password': password,
        'password_confirmation': passwordConfirmation,
        'email': email,
        'otp': otp,
      };

      final response = await http.put(
        Uri.parse(
          'https://foodtek-main-ognlf5.laravel.cloud/api/reset_password',
        ),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        emit(ResetPasswordSuccessState());
      } else {
        final responseData = jsonDecode(response.body);
        emit(
          ResetPasswordFailedState(
            errorMessage:
                responseData['message'] ?? 'Failed to reset password.',
          ),
        );
      }
    } catch (e) {
      emit(
        ResetPasswordFailedState(
          errorMessage: 'Connection error: ${e.toString()}',
        ),
      );
    }
  }

  Future<String?> getToken() async {
    return await SecureStorageHelper.instance.getPrefString(
      key: 'token',
      defaultValue: '',
    );
  }
}
