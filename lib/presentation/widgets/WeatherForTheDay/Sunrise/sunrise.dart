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

enum HeavenBody { SUN, MOON }

class Sunrise extends StatefulWidget {
  final DateTime sunrise;
  final DateTime sunset;

  Sunrise({this.sunrise, this.sunset});

  @override
  _SunriseState createState() => _SunriseState();
}

class _SunriseState extends State<Sunrise> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> offset;
  HeavenBody heavenBody = HeavenBody.SUN;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1600),
    );
    var dayDuration = widget.sunset.difference(widget.sunrise).inMilliseconds;
    var dayPercentage;
    double maxOffset = 30;

    if (DateTime.now().isBefore(widget.sunrise)) {
      dayPercentage = 1;
      setState(() {
        heavenBody = HeavenBody.MOON;
      });
    } else if (DateTime.now().isAfter(widget.sunset)) {
      dayPercentage = 1;
      setState(() {
        heavenBody = HeavenBody.MOON;
      });
    } else {
      var dayGone = DateTime.now().difference(widget.sunrise).inMilliseconds;
      if (dayGone > dayDuration / 2) {
        dayPercentage = (dayGone - dayDuration / 2) / dayDuration / 2;
      } else {
        dayPercentage = dayGone / dayDuration / 2;
      }
    }

    print(dayPercentage);
    offset = Tween<double>(begin: -100, end: maxOffset * dayPercentage)
        .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HorizonClip(),
      child: CustomPaint(
        painter: HorizonPainter(),
        child: Container(
          width: 150,
          height: 100,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Positioned(
                    bottom: offset.value,
                    child: Container(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SvgPicture.asset(
                            heavenBody == HeavenBody.SUN
                                ? 'assets/sunny.svg'
                                : 'assets/SVG/night_half_moon_clear.svg',
                            width: 50,
                            height: 50,
                            color: Colors.white,
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
