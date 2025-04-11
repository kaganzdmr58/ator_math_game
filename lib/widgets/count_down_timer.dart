import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final int seconds;
  final int state;
  final VoidCallback onFinished;
  final TextStyle? textStyle;

  const CountdownTimer({
    Key? key,
    required this.seconds,
    required this.onFinished,
    required this.state,
    this.textStyle,
  }) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late int _remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _remainingSeconds = widget.seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.state == 1) {
        timer.cancel();
        return;
      }
      if (_remainingSeconds == 0) {
        timer.cancel();
        widget.onFinished();
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle =
        widget.textStyle ??
        const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

    final effectiveStyle = baseStyle.copyWith(
      color: _remainingSeconds <= 5 ? Colors.red : baseStyle.color,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _remainingSeconds <= 5 ? Colors.red : Colors.grey,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.timer,
              color: _remainingSeconds <= 5 ? Colors.red : baseStyle.color,
              size: 28,
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 40,
              child: Center(
                child: Text('$_remainingSeconds', style: effectiveStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
