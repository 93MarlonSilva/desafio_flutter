import 'package:flutter/material.dart';
import '../common/extensions/context_extension.dart';

class CustomPageWidget extends StatefulWidget {
  final bool isLoading;
  final Widget child;

  const CustomPageWidget({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  State<CustomPageWidget> createState() => _CustomPageWidgetState();
}

class _CustomPageWidgetState extends State<CustomPageWidget> {
  @override
  void didUpdateWidget(CustomPageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading != oldWidget.isLoading) {
      if (widget.isLoading) {
        context.showLoading();
      } else {
        context.hideLoading();
      }
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
