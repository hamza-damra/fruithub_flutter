import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruitshub/auth/helpers/manage_users.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import '../state/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ManageUsers manageUsers;

  AuthCubit(this.manageUsers) : super(AuthInitial());

  Future<void> signUp(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      final response = await manageUsers.signUP(name, email, password);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String token = responseData['token'];
        await SharedPrefManager().saveData('token', token);
        emit(AuthSuccess());
        sendVerificationEmail(email);
      } else {
        emit(AuthError('فشل إنشاء الحساب. يرجى المحاولة مرة أخرى.'));
      }
    } catch (e) {
      emit(AuthError('حدث خطأ أثناء إنشاء الحساب. ${e.toString()}'));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final response = await manageUsers.signinUser(email, password);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String token = responseData['token'];
        await SharedPrefManager().saveData('token', token);
        emit(AuthSuccess());
      } else {
        emit(AuthError('فشل تسجيل الدخول. يرجى التحقق من بيانات الاعتماد الخاصة بك.'));
      }
    } catch (e) {
      emit(AuthError('حدث خطأ أثناء تسجيل الدخول. ${e.toString()}'));
    }
  }

  Future<void> sendResetPasswordEmail(String email) async {
    emit(AuthLoading());
    try {
      final response = await manageUsers.sendResetPasswordEmail(email);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(PasswordResetEmailSent());
      } else {
        emit(AuthError('حدث خطأ أثناء إرسال البريد الإلكتروني لإعادة تعيين كلمة المرور. يرجى المحاولة مرة أخرى.'));
      }
    } catch (e) {
      emit(AuthError('حدث خطأ أثناء إرسال البريد الإلكتروني لإعادة تعيين كلمة المرور. ${e.toString()}'));
    }
  }

  Future<void> verifyResetPassword(String otp, String password, String confirm) async {
    emit(AuthLoading());
    try {
      final response = await manageUsers.verifyResetPasswordByOtp(otp, password, confirm);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(PasswordResetSuccess());
      }
    } catch (e) {
      emit(AuthError('حدث خطأ أثناء إعادة تعيين كلمة المرور. ${e.toString()}'));
    }
  }

  Future<void> sendVerificationEmail(String email) async {
    emit(AuthLoading());
    try {
      final response = await manageUsers.verifyUser(email);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UserVerificationCodeSent());
      } else {
        emit(AuthError('حدث خطأ أثناء إرسال البريد الإلكتروني للتحقق. يرجى المحاولة مرة أخرى.'));
      }
    } catch (e) {
      emit(AuthError('حدث خطأ أثناء إرسال البريد الإلكتروني للتحقق. ${e.toString()}'));
    }
  }

  Future<void> confirmUser(String otp) async {
    emit(AuthLoading());
    try {
      final response = await manageUsers.confirmUser(otp);
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UserVerificationSuccess());
      } else {
        emit(AuthError('حدث خطأ أثناء تأكيد المستخدم. يرجى التحقق من رمز OTP والمحاولة مرة أخرى.'));
      }
    } catch (e) {
      emit(AuthError('حدث خطأ أثناء تأكيد المستخدم. ${e.toString()}'));
    }
  }
}
