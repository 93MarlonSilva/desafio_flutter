import 'package:flutter/material.dart';
import 'package:quizchallenge/common/app_colors.dart';

class ScoreCardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ScoreCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 144,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 24),
                Icon(icon, size: 32, color: AppColors.babyBlue),
                const SizedBox(width: 16),
                Text(title, style: Theme.of(context).textTheme.displayMedium!),
              ],
            ),
          ),
          Container(height: 1, color: AppColors.babyBlue),
          Expanded(
            child: Center(
              child: Text(
                value,
                style: Theme.of(context).textTheme.displayMedium!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
