import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  final String? error;
  final VoidCallback onTryAgain;

  const ErrorIndicator({
    super.key,
    this.error,
    required this.onTryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'An error occurred: $error',
            style: const TextStyle(color: Colors.red, fontSize: 18),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onTryAgain,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
