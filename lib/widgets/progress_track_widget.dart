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
    final validTotalQuestions = totalQuestions > 0 ? totalQuestions : 1;
    final validCurrentIndex = currentIndex.clamp(0, validTotalQuestions - 1);

    // Horizontal side padding
    const externalPadding = 20.0; 
    final totalScreenWidth = MediaQuery.of(context).size.width - externalPadding;

    // Calc space used by track
    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.percentageText,
        );
    final textPainter = TextPainter(
      text: TextSpan(
        text: '$validTotalQuestions/$validTotalQuestions',
        style: textStyle,
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final textWidth = textPainter.width;
    const sizedBoxWidth = 12.0; 
    const internalPadding = 32.0; // Internal padding

    // Space available for track
    final screenWidth = totalScreenWidth - internalPadding - textWidth - sizedBoxWidth;

    // Indicator width (dynamic based on number of questions)
    final minIndicatorWidth = 40.0;
    final maxIndicatorWidth = 80.0;
    final indicatorWidth = (screenWidth / validTotalQuestions).clamp(
      minIndicatorWidth,
      maxIndicatorWidth,
    );

    // Space available for indicator
    final trackWidth = screenWidth - indicatorWidth;

    // Space between indicator positions
    final spacing = validTotalQuestions > 1 ? trackWidth / (validTotalQuestions - 1) : 0.0;

    // Current indicator position (ensuring it doesn't exceed limits)
    final indicatorPosition = (validCurrentIndex * spacing).clamp(0.0, trackWidth);

    return SizedBox(
      width: totalScreenWidth - internalPadding,
      child: Row(
        children: [
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
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
                    width: indicatorWidth,
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
          const SizedBox(width: sizedBoxWidth),
          Text(
            '${validCurrentIndex + 1}/$validTotalQuestions',
            style: textStyle,
          ),
        ],
      ),
    );
  }
}