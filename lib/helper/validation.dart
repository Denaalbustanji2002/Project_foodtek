import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/phone_number.dart';

class Validation {
  TextEditingController fullNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController birthOfDateTextEditingController =
      TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController newPasswordTextEditingController =
      TextEditingController();
  TextEditingController passwordConfirmationTextEditingController =
      TextEditingController();
  TextEditingController otpTextEditingController = TextEditingController();

  bool showErrorFullName = false;
  bool showErrorEmail = false;
  bool showErrorPhone = false;
  bool showErrorPassword = false;
  bool showErrorConfirmPassword = false;
  bool obscureTextPassword = true;
  bool showErrorNewPassword = false;
  bool showErrorConfirmNewPassword = false;
  bool showErrorBirthDate = false;
  bool rememberMe = false;
  String savedEmail = "";
  String savedPassword = "";
  String savedOtp = "";
  String savedNewPassword = "";
  String savedConfirmNewPassword = "";
  bool isLoading = false;
  String? errorMessage = "";
  String? phoneErrorText;

  void errorListener() {
    fullNameTextEditingController.addListener(() {
      checkFullName(fullName: fullNameTextEditingController.text);
    });
    emailTextEditingController.addListener(() {
      checkEmail(email: emailTextEditingController.text);
    });
    birthOfDateTextEditingController.addListener(() {
      checkBirthDate();
    });
    phoneTextEditingController.addListener(() {
      checkPhone(phone: phoneTextEditingController.text);
    });
    passwordTextEditingController.addListener(() {
      checkPassword(password: passwordTextEditingController.text);
    });
    newPasswordTextEditingController.addListener(() {
      checkNewPassword(newPassword: newPasswordTextEditingController.text);
    });
    passwordConfirmationTextEditingController.addListener(() {
      checkConfirmNewPassword(
        passwordConfirmation: passwordConfirmationTextEditingController.text,
        newPassword: newPasswordTextEditingController.text,
      );
    });
  }

  void checkBirthDate() {
    if (birthOfDateTextEditingController.text.isNotEmpty) {
      try {
        DateTime pickedDate = DateFormat(
          "dd/MM/yyyy",
        ).parse(birthOfDateTextEditingController.text);
        showErrorBirthDate = false;
      } catch (e) {
        showErrorBirthDate = true;
      }
    } else {
      showErrorBirthDate = true;
    }
  }

  void checkFullName({required String fullName}) {
    fullName = fullName.trim();
    fullName = fullName.replaceAll(' ', '');
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z]+$');
    showErrorFullName = !nameRegExp.hasMatch(fullName);
  }

  void checkEmail({required String email, bool isLogin = false}) {
    if (isLogin) {
      showErrorEmail = email.isEmpty;
      if (showErrorEmail) {
        errorMessage = "Email cannot be empty.";
      }
    } else {
      String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
      RegExp regExp = RegExp(pattern);

      showErrorEmail = !regExp.hasMatch(email) || email.isEmpty;

      if (showErrorEmail) {
        errorMessage =
            "Please enter a valid email address with a valid domain (gmail, hotmail, outlook, zoho, yahoo).";
      }
    }
  }

  void checkPhone({required String phone}) {
    bool showErrorPhone = false;
    String? phoneErrorText;
    if (phone.isEmpty) {
      showErrorPhone = true;
      phoneErrorText = 'Phone number cannot be empty';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      showErrorPhone = true;
      phoneErrorText = 'Phone number must contain only digits';
    } else if (phone.length != 10) {
      showErrorPhone = true;
      phoneErrorText = 'Phone number must be 10 digits';
    }

    if (showErrorPhone) {
    } else {}
  }

  void checkPassword({required String password, bool isLogin = false}) {
    if (isLogin) {
      showErrorPassword = password.isEmpty;
    } else {
      final RegExp regExp = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
      );

      showErrorPassword = !regExp.hasMatch(password);
    }
  }

  void changeObscureTextPassword() {
    obscureTextPassword = !obscureTextPassword;
  }

  void checkNewPassword({required String newPassword}) {
    final RegExp regExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
    );
    showErrorNewPassword = !regExp.hasMatch(newPassword);
  }

  void checkConfirmNewPassword({
    required String newPassword,
    required String passwordConfirmation,
  }) {
    showErrorConfirmNewPassword =
        newPassword != passwordConfirmation || passwordConfirmation.isEmpty;
  }
}
