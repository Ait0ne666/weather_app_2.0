import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/painting.dart' as painting;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:image/image.dart' as image;

const assets = [
  'assets/128/day_clear.png',
  'assets/128/night_half_moon_clear.png'
];

class AnimatedDay extends StatelessWidget {
  final WeatherWithHourlyForecast weather;

  AnimatedDay(this.weather);

  Future<ui.Image> loadImage(String asset) async {
    final ByteData data = await rootBundle.load(asset);

    // var immutableBuffer =
    //     await ui.ImmutableBuffer.fromUint8List(data.buffer.asUint8List());
    // var descriptor = ui.ImageDescriptor.raw(immutableBuffer,
    //     width: 40, height: 40, pixelFormat: ui.PixelFormat.bgra8888);
    // final ui.Codec codec = await descriptor.instantiateCodec(
    //   targetHeight: 20,
    //   targetWidth: 20,
    // );
    final ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetHeight: 20,
        targetWidth: 20,
        allowUpscaling: false);
    final ui.FrameInfo fi = await codec.getNextFrame();

    return fi.image;
  }

  Future<Map<String, ui.Image>> loadImages() async {
    Map<String, ui.Image> images = {};

    for (int i = 0; i < assets.length; i++) {
      ui.Image image = await loadImage(assets[i]);
      images[assets[i]] = image;
    }

    return images;
  }

  @override
  Widget build(BuildContext context) {
    int dayDuration = weather.sunset.difference(weather.sunrise).inMilliseconds;
    int dayGone = DateTime.now().difference(weather.sunrise).inMilliseconds;
    double dayPercentage = dayGone / dayDuration;
    return Container(
      child: FutureBuilder(
        future: loadImages(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AnimatedHorizon(
              image: snapshot.data['assets/128/day_clear.png'],
              imageMoon: snapshot.data['assets/128/night_half_moon_clear.png'],
              sunrise: weather.sunrise,
              sunset: weather.sunset,
              dayPercentage: dayPercentage,
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}

class AnimatedHorizon extends StatefulWidget {
  final DateTime sunrise;
  final DateTime sunset;
  final ui.Image image;
  final ui.Image imageMoon;
  final double dayPercentage;

  AnimatedHorizon(
      {this.sunrise,
      this.sunset,
      this.image,
      this.dayPercentage,
      this.imageMoon});

  @override
  _AnimatedHorizonState createState() => _AnimatedHorizonState();
}

class _AnimatedHorizonState extends State<AnimatedHorizon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  Key key = UniqueKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1200),
        reverseDuration: Duration(milliseconds: 0));
    _animation = Tween<double>(begin: 0, end: widget.dayPercentage)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    // _controller.forward();
  }

  void startAnimation(VisibilityInfo info) {
    if (info.visibleFraction > 0.9) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('HH:mm');
    String rise = format.format(widget.sunrise);
    String fall = format.format(widget.sunset);

    return VisibilityDetector(
      onVisibilityChanged: startAnimation,
      key: key,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: HorizonPainter(
                sun: widget.image,
                sunrise: rise,
                sunset: fall,
                moon: widget.imageMoon,
                dayPercentage: _animation.value),
            child: Container(height: 150),
          );
        },
      ),
    );
  }
}

class HorizonPainter extends CustomPainter {
  final ui.Image sun;
  final ui.Image moon;
  final double dayPercentage;
  final String sunrise;
  final String sunset;

  HorizonPainter(
      {this.sun, this.sunrise, this.sunset, this.dayPercentage, this.moon});

  Offset getImagePositionFromDay(
      double dayPercentage, Size size, ui.Image sun) {
    double dx = size.width * 0.8 * dayPercentage;
    double dy = sqrt(size.width * 0.8 / 2 * size.width * 0.8 / 2 -
        (dx - size.width * 0.8 / 2) * (dx - size.width * 0.8 / 2));
    return Offset(dx + size.width * 0.1 - sun.width / 2,
        -dy - sun.height / 2 + size.height * 0.9);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint();
    linePaint.style = PaintingStyle.stroke;
    linePaint.color = Colors.white.withOpacity(0.6);
    Paint imagePaint = Paint();
    Paint dayGonePaint = Paint();
    dayGonePaint.color = Colors.white.withOpacity(0.15);
    dayGonePaint.style = PaintingStyle.fill;

    canvas.drawLine(Offset(0, size.height * 0.9),
        Offset(size.width, size.height * 0.9), linePaint);

    Path path = Path();
    path.moveTo(size.width * 0.1, size.height * 0.9);
    path.arcToPoint(Offset(size.width * 0.9, size.height * 0.9),
        radius: Radius.circular(size.width * 0.8 / 2));
    path.close();

    Path dayGonePath = Path();

    Offset sunOffset;
    if (dayPercentage < 1) {
      sunOffset = getImagePositionFromDay(dayPercentage, size, sun);
    } else {
      sunOffset = Offset(size.width * 0.9 - moon.width / 2,
          size.height * 0.9 - moon.height / 2);
    }

    dayGonePath.moveTo(size.width * 0.1, size.height * 0.9);
    dayGonePath.arcToPoint(
        Offset(sunOffset.dx + sun.width / 2, sunOffset.dy + sun.height / 2),
        radius: Radius.circular(size.width * 0.8 / 2));

    double dayGone = size.width * 0.1 +
        size.width * 0.8 * (dayPercentage > 1 ? 1 : dayPercentage);

    dayGonePath.lineTo(dayGone, size.height * 0.9);

    canvas.drawPath(dayGonePath, dayGonePaint);
    canvas.drawPath(path, linePaint);
    if (dayPercentage < 1) {
      canvas.drawImage(sun, sunOffset, imagePaint);
    } else {
      canvas.drawImage(moon, sunOffset, imagePaint);
    }

    TextPainter textPainter = TextPainter();

    textPainter.text = TextSpan(
        text: sunrise, style: TextStyle(fontSize: 12, color: Colors.white));
    textPainter.textDirection = painting.TextDirection.ltr;
    textPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    textPainter.paint(
        canvas,
        Offset(
            size.width * 0.1 - textPainter.width / 2, size.height * 0.9 + 5));
    textPainter.text = TextSpan(
        text: sunset, style: TextStyle(fontSize: 12, color: Colors.white));
    textPainter.textDirection = painting.TextDirection.ltr;
    textPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    textPainter.paint(
        canvas,
        Offset(
            size.width * 0.9 - textPainter.width / 2, size.height * 0.9 + 5));
  }

  @override
  bool shouldRepaint(HorizonPainter oldDelegate) => true;
}
