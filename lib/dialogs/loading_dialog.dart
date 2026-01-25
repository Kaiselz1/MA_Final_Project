import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (_) => const _LoadingDialog(),
  );
}

class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Lottie.asset('assets/lottie/Loading.json'),
      ),
    );
  }
}
