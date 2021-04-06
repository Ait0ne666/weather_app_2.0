import 'package:flutter/material.dart';

class BounceTap extends StatefulWidget {
  final Widget child;
  final Function onTap;

  BounceTap({this.child, this.onTap});

  @override
  _BounceTapState createState() => _BounceTapState();
}

class _BounceTapState extends State<BounceTap>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _animation = Tween<double>(begin: 1, end: 0.8)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _animation.addListener(() {
      print(1);
      print(_animation.value);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: GestureDetector(
        child: widget.child,
        onTapDown: (details) => _controller.forward(),
        onTapUp: (details) => _controller.reverse(),
        onTap: widget.onTap,
      ),
    );
  }
}
