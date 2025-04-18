import 'package:flutter/material.dart';

class WidgetListQuizItem extends StatelessWidget {
  final String letter;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const WidgetListQuizItem({
    super.key,
    required this.letter,
    required this.text,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 335,
        height: 60,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.secondary : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected ? theme.colorScheme.surface : theme.colorScheme.background,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  letter,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isSelected ? theme.colorScheme.secondary : theme.colorScheme.onBackground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
