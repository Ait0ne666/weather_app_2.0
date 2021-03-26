import 'package:flutter/material.dart';

class Sky extends StatelessWidget {
  final List<Color> gradientColors;
  final List<double> gradientStops;

  Sky({this.gradientColors, this.gradientStops});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
          // stops: gradientStops,
        ),
      ),
    );
  }
}
