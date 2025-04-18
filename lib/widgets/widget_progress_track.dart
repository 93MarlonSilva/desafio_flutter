import 'package:flutter/material.dart';

class WidgetProgressTrack extends StatelessWidget {
  final int currentIndex;
  final int totalQuestions;

  const WidgetProgressTrack({
    super.key,
    required this.currentIndex,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = (currentIndex + 1) / totalQuestions;
    final indicatorPosition = progress * (300 - 60); // 300 is track width, 60 is indicator width

    return SizedBox(
      width: 335, // Same width as other components
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Background track
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                // Progress indicator
                Positioned(
                  left: indicatorPosition,
                  child: Container(
                    width: 60,
                    height: 12,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
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
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onBackground.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
} 