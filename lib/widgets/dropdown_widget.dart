import 'package:flutter/material.dart';
import 'package:quizchallenge/common/app_colors.dart';

class CustomDropdownWidget<T> extends StatelessWidget {
  final T? value;
  final String label;
  final List<T> items;
  final Function(T?) onChanged;
  final String Function(T) itemToString;
  final bool enabled;

  const CustomDropdownWidget({
    super.key,
    required this.value,
    required this.label,
    required this.items,
    required this.onChanged,
    required this.itemToString,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          elevation: 4,
          value: value,
          isExpanded: true,
          menuMaxHeight: 400,
          borderRadius: BorderRadius.circular(8),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          menuWidth: double.infinity,
          hint: Text(label, style: Theme.of(context).textTheme.displayMedium!),
          items:
              items.map((item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    itemToString(item),
                    style: Theme.of(context).textTheme.displayMedium!,
                  ),
                );
              }).toList(),
          onChanged: enabled ? onChanged : null,
          icon: Icon(Icons.arrow_drop_down, color: AppColors.babyBlue),
        ),
      ),
    );
  }
}
