import 'package:flutter/material.dart';
import 'package:quizchallenge/common/app_colors.dart';

enum ShowBottomToastType { error, success, warning, alert, message, mainColor }

class AppFunctions {
  static dynamic ifThen({
    required bool parComparison,
    required dynamic parTrueOption,
    required dynamic parFalseOption,
  }) => parComparison ? parTrueOption : parFalseOption;

  static void showOverlayMessage({
    required BuildContext context,
    required String message,
    required ShowBottomToastType type,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            bottom: 0,
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  decoration: BoxDecoration(
                    color:
                        type == ShowBottomToastType.error
                            ? Color(0xFFE24739)
                            : type == ShowBottomToastType.alert
                            ? Color.fromARGB(255, 212, 167, 43)
                            : type == ShowBottomToastType.success
                            ? Color(0xFF00B147)
                            : type == ShowBottomToastType.message
                            ? Colors.blueGrey
                            : type == ShowBottomToastType.warning
                            ? Color.fromARGB(255, 235, 157, 13)
                            : type == ShowBottomToastType.mainColor
                            ? Colors.black54
                            : AppColors.babyBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      message,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: 8), () => overlayEntry.remove());
  }
}
