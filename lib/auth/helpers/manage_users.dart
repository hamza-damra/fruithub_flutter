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

  Future<http.Response> signinUser(String email, String password) async {
    final response = await http.post(
      Uri.parse(
        'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/users/login?email=$email&password=$password',
      ),
    );

    return response;
  }

  Future<http.Response> sendResetPasswordEmail(String email) async {
    http.Response verificationResponse = await http.post(
      Uri.parse(
        'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/forgotPassword/verifyMail/$email',
      ),
    );
    return verificationResponse;
  }

  Future<http.Response> verifyResetPasswordByOtp(
      String otp, String password, String confirm) async {
    http.Response verificationResponse = await http.post(
      Uri.parse(
        'https://fruitappbackendspringbootrestfullapijava.onrender.com/api/v1/forgotPassword/resetPassword/$otp',
      ),
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
}
