import 'package:flutter/material.dart';
import 'package:quizchallenge/common/app_colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final bool enabled;
  final VoidCallback? onPressed;

  const CustomButtonWidget({
    super.key,
    required this.text,
    this.enabled = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              enabled ? AppColors.babyBlue : AppColors.disabledButton,
          foregroundColor:
              enabled ? AppColors.babyBlue : AppColors.disabledButton,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: enabled ? AppColors.backgroundLight : AppColors.background,
          ),
        ),
      ),
    );
  }
}
