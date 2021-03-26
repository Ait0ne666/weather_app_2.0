import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/svg.dart';

class HorizonClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 40, size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<dynamic> clipper) {
    return true;
  }
}

class HorizonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    paint.color = Colors.white;

    LinearGradient gradient = LinearGradient(
        colors: [Colors.white, Colors.white.withAlpha(120)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.75, 1]);

    Rect rect = Offset.zero & size;

    path.moveTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 40, size.width, size.height);
    path.quadraticBezierTo(size.width / 2, size.height - 48, 0, size.height);

    canvas.drawPath(path, Paint()..shader = gradient.createShader(rect));
  }

  @override
  bool shouldRepaint(CustomPainter painter) {
    return true;
  }
}

class Sunrise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HorizonClip(),
      child: CustomPaint(
        painter: HorizonPainter(),
        child: Container(
          width: 150,
          height: 100,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset('assets/sunny.svg',
                width: 50, height: 50, fit: BoxFit.fitWidth),
          ),
        ),
      ),
    );
  }
}
