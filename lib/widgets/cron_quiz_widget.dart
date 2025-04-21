import 'package:flutter/material.dart';
import 'package:quizchallenge/common/app_colors.dart';
import 'dart:async';

class CronQuizWidget extends StatefulWidget {
  final Function(int) onTimeUpdate;
  final VoidCallback onTimeEnd;
  final int initialSeconds;
  final ValueNotifier<bool> isRunning;

  const CronQuizWidget({
    super.key,
    required this.onTimeUpdate,
    required this.onTimeEnd,
    required this.isRunning,
    this.initialSeconds = 60,
  });

  @override
  State<CronQuizWidget> createState() => _CronQuizWidgetState();
}

class _CronQuizWidgetState extends State<CronQuizWidget> {
  late int _seconds;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _seconds = widget.initialSeconds;
    _startTimer();
    widget.isRunning.addListener(_onRunningChanged);
  }

  @override
  void dispose() {
    _timer.cancel();
    widget.isRunning.removeListener(_onRunningChanged);
    super.dispose();
  }

  void _onRunningChanged() {
    if (!widget.isRunning.value) {
      _timer.cancel();
      debugPrint('CronQuizWidget: Timer fechado');
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0 && widget.isRunning.value) {
        setState(() {
          _seconds--;
          widget.onTimeUpdate(_seconds);
          debugPrint(
            'CronQuizWidget: Tempo atualizado para $_seconds segundos',
          );
        });
      } else if (_seconds == 0) {
        debugPrint('CronQuizWidget: Tempo acabou!');
        widget.onTimeEnd();
        _timer.cancel();
      }
    });
  }

  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _seconds = widget.initialSeconds;
    });
    _startTimer();
    debugPrint('CronQuizWidget: Timer reiniciado com $_seconds segundos');
  }

  @override
  void didUpdateWidget(CronQuizWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialSeconds != widget.initialSeconds) {
      debugPrint(
        'CronQuizWidget: Reiniciando timer com ${widget.initialSeconds} segundos',
      );
      _resetTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 22,
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: AppColors.darkBlue,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            '$_seconds',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
