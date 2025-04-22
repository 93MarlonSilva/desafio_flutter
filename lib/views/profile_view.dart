import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizchallenge/common/app_colors.dart';
import 'package:quizchallenge/widgets/bottom_menu_widget.dart';
import '../viewmodels/profile_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Consumer<ProfileViewModel>(
          builder: (context, viewModel, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,  horizontal: 20),
              child: Row(
                children: [
                  const SizedBox(height: 40),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/home.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Text(
                    'Profile',
                    style: Theme.of(context).textTheme.displayLarge!,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomMenuWidget(),
    );
  }
}
