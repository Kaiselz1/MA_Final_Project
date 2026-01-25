import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/setting_controller.dart';

Future<void> showSuccess(BuildContext context, String message) async {
  final SettingController controller = Get.find<SettingController>();
  final bool isDark = controller.isDark;

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/lottie/Success.json',
                width: 140,
                repeat: false,
              ),
              const SizedBox(height: 10),
              Text(
                "success".tr,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: isDark ? Colors.white38 : Colors.black38 ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("ok".tr),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
