import 'package:flutter/material.dart';

class PopupHelper {
  static void showInfoPopup(BuildContext context, String title, String message) {
    _showDialog(
      context,
      title,
      message,
      Icons.info,
      Colors.blue,
    );
  }

  static void showErrorPopup(BuildContext context, String title, String message) {
    _showDialog(
      context,
      title,
      message,
      Icons.error,
      Colors.red,
    );
  }

  static void showSuccessPopup(BuildContext context, String title, String message) {
    _showDialog(
      context,
      title,
      message,
      Icons.check_circle,
      Colors.green,
    );
  }

  static void showLoadingPopup(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  message ?? 'Loading...',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void hideLoadingPopup(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void _showDialog(
    BuildContext context,
    String title,
    String message,
    IconData icon,
    Color iconColor,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 10),
              Text(title),
            ],
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
