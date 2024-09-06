import 'package:flutter/material.dart';
import '../bloc/state/auth_state.dart';

class ErrorHandler {
 static void handleAuthError(BuildContext context, AuthState state) {
    if (state is AuthError) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'خطأ',
              textAlign: TextAlign.right,
            ),
            content: Text(
              state.message,
              textAlign: TextAlign.right,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('حسنًا'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

}
