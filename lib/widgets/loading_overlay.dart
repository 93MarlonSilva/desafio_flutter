import 'package:flutter/material.dart';
import 'package:quizchallenge/common/app_colors.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.progressBar,
          strokeWidth: 4,
        ),
      ),
    );
  }
}
