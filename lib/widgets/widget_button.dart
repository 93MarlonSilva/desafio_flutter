import 'package:flutter/material.dart';

class WidgetCustomButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final VoidCallback? onPressed;

  const WidgetCustomButton({
    super.key,
    required this.text,
    this.enabled = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      width: 335,
      height: 60,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled 
              ? theme.colorScheme.primary 
              : theme.colorScheme.surface.withOpacity(0.5),
          foregroundColor: enabled 
              ? theme.colorScheme.onPrimary 
              : theme.colorScheme.onSurface.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
