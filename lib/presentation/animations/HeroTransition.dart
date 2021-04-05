import 'package:flutter/material.dart';

class HeroTransition extends AnimatedWidget {
  final Size initialSize;
  final Offset initialOffset;
  final Widget child;
  final Size screenSize;

  HeroTransition(
      {Key key,
      Animation controller,
      this.initialSize,
      this.initialOffset,
      this.child,
      this.screenSize})
      : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable as Animation<double>;
  Animation<Offset> get offsetTween =>
      Tween<Offset>(begin: initialOffset, end: Offset.zero)
          .animate(CurvedAnimation(parent: _progress, curve: Curves.easeInOut));
  Animation<Size> get sizeTween =>
      Tween<Size>(begin: initialSize, end: screenSize)
          .animate(CurvedAnimation(parent: _progress, curve: Curves.easeInOut));

  @override
  Widget build(BuildContext context) {
    print(_progress.value);
    return Stack(
      children: [
        Positioned(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: sizeTween.value.width,
              height: sizeTween.value.height,
              child: child,
            ),
          ),
          top: offsetTween.value.dy,
          left: offsetTween.value.dx,
        ),
      ],
    );
  }
}
