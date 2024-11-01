// lib/auth/helpers/manage_users.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

class ManageUsers {
  Future<http.Response> signUP(
      String name, String email, String password) async {
    final url = Uri.parse(
        'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/users/register');

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "roles": [
          {"name": "USER"}
        ]
      }),
    );

    return response;
  }

  Future<http.Response> verifyUser(String email) async {
    final url = Uri.parse(
        'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/users/sendVerificationEmail/$email');
    final response = await http.post(url);
    return response;
  }

  Future<http.Response> confirmUser(String otp) async {
    final url = Uri.parse(
        'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/users/verifyAccount/$otp');
    final response = await http.post(url);
    return response;
  }

  Future<http.Response> signInUser(String email, String password) async {
    final response = await http.post(
      Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/users/login?email=$email&password=$password'),
    );

    print(response.body);

    return response;
  }

  Future<http.Response> sendResetPasswordEmail(String email) async {
    http.Response verificationResponse = await http.post(
      Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/forgotPassword/verifyMail/$email'),
    );
    return verificationResponse;
  }

  Future<http.Response> verifyResetPasswordByOtp(
      String otp, String password, String confirm) async {
    http.Response verificationResponse = await http.post(
      Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/forgotPassword/resetPassword/$otp'),
      body: jsonEncode({
        "newPassword": password,
        "confirmPassword": confirm,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return verificationResponse;
  }

  Future<http.Response> sendResetEmailOtpMessage({
    required String email,
  }) async {
    http.Response otpResponse = await http.post(
      Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/resetEmail/verifyMail/$email'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return otpResponse;
  }

  Future<http.Response> verifyOtpAndResetEmail({
    required String otp,
    required String newEmail,
    required String confirmEmail,
  }) async {
    http.Response verifyResponse = await http.post(
      Uri.parse(
          'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/resetEmail/resetEmail/$otp'),
      body: jsonEncode(
        {
          "newEmail": newEmail,
          "confirmEmail": confirmEmail,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return verifyResponse;
  }
}
