import 'package:flutter/material.dart';

class ExceptionHandler {
  /// Show a user-friendly snackbar with [message]
  static void showError(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger != null) {
      messenger.clearSnackBars();
      messenger.showSnackBar(SnackBar(content: Text(message)));
    } else {
      // fallback: show dialog
      showDialog(
        context: context,
        builder: (c) => AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(onPressed: () => Navigator.of(c).pop(), child: const Text('OK'))
          ],
        ),
      );
    }
  }
}
