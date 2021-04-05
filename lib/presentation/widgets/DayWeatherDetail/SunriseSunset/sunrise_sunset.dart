import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:weather_app2/presentation/widgets/DayWeatherDetail/SunriseSunset/AnimatedDay/animated_day.dart';

class SunriseSunset extends StatelessWidget {
  final Weather weather;

  SunriseSunset(this.weather);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(bottom: 20),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 40,
            sigmaY: 40,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withOpacity(0.1),
            ),
            padding: EdgeInsets.only(top: 15, left: 25, right: 25, bottom: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sunrise/Sunset',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(height: 1, color: Colors.white.withOpacity(0.3)),
                SizedBox(
                  height: 5,
                ),
                AnimatedDay(weather),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
