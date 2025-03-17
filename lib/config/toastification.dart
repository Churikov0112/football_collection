import 'package:flutter/widgets.dart';
import 'package:toastification/toastification.dart';

final toastificationConfig = ToastificationConfig(
  alignment: Alignment.topCenter,
  itemWidth: 440,
  animationDuration: const Duration(milliseconds: 500),
  marginBuilder: (context, alignment) => const EdgeInsets.only(top: 16),
);
