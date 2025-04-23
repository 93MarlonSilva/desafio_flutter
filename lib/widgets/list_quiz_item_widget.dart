import 'package:flutter/material.dart';
import 'package:quizchallenge/common/app_colors.dart';

class ListQuizItemWidget extends StatelessWidget {
  final String letter;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const ListQuizItemWidget({
    super.key,
    required this.letter,
    required this.text,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color:
              isSelected ? AppColors.babyBlueLight : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? AppColors.backgroundLight
                        : AppColors.background,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Visibility(
                  visible: isSelected,
                  replacement: Text(
                    letter,
                    style: Theme.of(context).textTheme.displayMedium!,
                  ),
                  child: Icon(Icons.check, size: 20, color: AppColors.babyBlue),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color:
                      isSelected
                          ? AppColors.backgroundLight
                          : AppColors.darkBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
