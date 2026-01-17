import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showSuccess(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => _SuccessDialog(message: message),
  );
}

class _SuccessDialog extends StatelessWidget {
  final String message;

  const _SuccessDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/lottie/Success.json',
              width: 120,
              height: 120,
              repeat: false,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      ),
    );
  }
}
