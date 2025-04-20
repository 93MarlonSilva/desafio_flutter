import 'package:flutter/material.dart';
import '../common/app_colors.dart';

class ProgressTrackWidget extends StatelessWidget {
  final int currentIndex;
  final int totalQuestions;

  const ProgressTrackWidget({
    super.key,
    required this.currentIndex,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (currentIndex) / totalQuestions;
    final indicatorPosition = progress * (300 - 60);

    return SizedBox(
      width: MediaQuery.of(context).size.width - 42,
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                Positioned(
                  left: indicatorPosition,
                  child: Container(
                    width: 60,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.babyBlue,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${currentIndex + 1}/$totalQuestions',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.percentageText),
          ),
        ],
      ),
    );
  }
}
