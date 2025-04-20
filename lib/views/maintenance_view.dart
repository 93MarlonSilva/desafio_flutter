import 'package:flutter/material.dart';
import 'package:quizchallenge/common/app_colors.dart';
import 'package:quizchallenge/widgets/button_widget.dart';
import 'package:quizchallenge/widgets/custom_page_widget.dart';

class MaintenanceView extends StatelessWidget {
  const MaintenanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPageWidget(
      isLoading: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Icon(
                  Icons.error_outline_rounded,
                  size: 64,
                  color: AppColors.blackCustom,
                ),
                const SizedBox(height: 24),
                Text(
                  'Não foi possível carregar o quiz no momento',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium!,
                ),
                const SizedBox(height: 16),
                Text(
                  'Tente novamente mais tarde',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium!,
                ),
                const Spacer(),
                CustomButtonWidget(
                  text: 'Voltar ao Menu',
                  enabled: true,
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (route) => false,
                    );
                  },
                ),
                const SizedBox(height: 58),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
