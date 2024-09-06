abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class PasswordResetEmailSent extends AuthState {}

class PasswordResetSuccess extends AuthState {}

class UserVerificationCodeSent extends AuthState {}

class UserVerificationSuccess extends AuthState {}
