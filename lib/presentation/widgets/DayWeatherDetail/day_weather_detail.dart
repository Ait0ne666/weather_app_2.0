import 'package:flutter/material.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:weather_app2/presentation/widgets/DayWeatherDetail/DayTemperature/day_temperature.dart';
import 'package:weather_app2/presentation/widgets/DayWeatherDetail/Details/details.dart';

class DayWeatherDetail extends StatelessWidget {
  final Weather dayWeather;

  DayWeatherDetail({this.dayWeather});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white.withOpacity(0.2),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        children: [
          DayTemperature(
            dayTemp: dayWeather.dayTemp,
            eveTemp: dayWeather.dayTemp,
            nightTemp: dayWeather.nightTemp,
            mornTemp: dayWeather.mornTemp,
          ),
          SizedBox(height: 20),
          Details(dayWeather),

        ],
      ),
    );
  }
}
