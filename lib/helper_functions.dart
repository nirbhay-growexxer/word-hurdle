import 'package:flutter/material.dart';

void showMessage(BuildContext context, String message) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));

void showResult(
    {required BuildContext context,
    required String body,
    required VoidCallback onPlayAgain,
    required VoidCallback onCancel}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Result'),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onPlayAgain();
            },
            child: const Text('Play Again'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onCancel();
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
