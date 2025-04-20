import 'package:flutter/material.dart';
import '../../widgets/loading_overlay.dart';

extension BuildContextExtension on BuildContext {
  void showLoading() {
    showDialog(
      context: this,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (_) => const LoadingOverlay(),
    );
  }

  void hideLoading() {
    if (Navigator.canPop(this)) {
      Navigator.pop(this);
    }
  }
}
