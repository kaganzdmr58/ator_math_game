import 'package:flutter/material.dart';

class FalsePopupAnimation extends StatefulWidget {
  const FalsePopupAnimation({super.key});

  @override
  _FalsePopupAnimationState createState() => _FalsePopupAnimationState();
}

class _FalsePopupAnimationState extends State<FalsePopupAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _fade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    Future.delayed(Duration(seconds: 3), () {
      _controller.reverse().then((_) {
        if (mounted) Navigator.of(context).pop(); 
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _fade,
        child: Icon(Icons.cancel, color: Colors.red, size: 100),
      ),
    );
  }
}
