import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastService {
  static void showToast({
    required String title,
    BuildContext? context,
    String? subtitle,
    int seconds = 5,
  }) {
    toastification.show(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      autoCloseDuration: Duration(seconds: seconds),
      dismissDirection: DismissDirection.up,
      context: context,
      icon: const Icon(Icons.check_outlined, size: 36, color: Color.fromARGB(255, 0, 208, 49)),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      description: subtitle == null
          ? null
          : Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
      closeButtonShowType: CloseButtonShowType.none,
    );
  }

  static void showErrorToast({
    String? title,
    BuildContext? context,
    String? subtitle,
    int seconds = 5,
  }) {
    toastification.show(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      autoCloseDuration: Duration(seconds: seconds),
      dismissDirection: DismissDirection.up,
      context: context,
      type: ToastificationType.error,
      icon: const Icon(Icons.error_outline, size: 36, color: Color(0xFFED3F3F)),
      title: Text(
        title ?? 'Ошибка!',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      description: subtitle == null
          ? null
          : Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
      closeButtonShowType: CloseButtonShowType.none,
    );
  }
}
