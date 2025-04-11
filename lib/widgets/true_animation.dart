import 'package:flutter/material.dart';

class TruePopupAnimation extends StatefulWidget {
  const TruePopupAnimation({super.key});

  @override
  _TruePopupAnimationState createState() => _TruePopupAnimationState();
}

class _TruePopupAnimationState extends State<TruePopupAnimation>
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

    // 3 saniye sonra kaybolacak
    Future.delayed(Duration(seconds: 3), () {
      _controller.reverse().then((_) {
        if (mounted) Navigator.of(context).pop(); // Popup'u kapat
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
        child: Icon(Icons.check_circle, color: Colors.green, size: 100),
      ),
    );
  }
}
