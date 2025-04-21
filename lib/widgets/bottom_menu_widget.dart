import 'package:flutter/material.dart';
import 'package:quizchallenge/common/app_colors.dart';
import 'package:quizchallenge/common/routes.dart';

class BottomMenuWidget extends StatelessWidget {
  const BottomMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? Routes.home;

    return Container(
      height: 80,
      padding: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMenuItem(
            context,
            icon: Icons.home_rounded,
            label: '',
            route: Routes.home,
            isSelected: currentRoute == Routes.home,
          ),
          _buildMenuItem(
            context,
            icon: Icons.history_rounded,
            label: '',
            route: Routes.history,
            isSelected: currentRoute == Routes.history,
          ),
          _buildMenuItem(
            context,
            icon: Icons.person_rounded,
            label: '',
            route: Routes.profile,
            isSelected: currentRoute == Routes.profile,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          route,
          (route) => false,
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.babyBlue : AppColors.disabledButton,
            size: 32,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected ? AppColors.babyBlue : AppColors.background,
                ),
          ),
        ],
      ),
    );
  }
} 