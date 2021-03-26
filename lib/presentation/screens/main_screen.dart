import 'package:flutter/material.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:weather_app2/dummyData/weatherData.dart';
import 'package:weather_app2/presentation/widgets/WeatherForTheDay/weather_for_the_day.dart';
import 'package:weather_app2/presentation/widgets/common/Sky/sky.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Sky(
          gradientColors: [
            Color(0xff631961),
            Color(0xffE94057),
            Color(0xffF27121)
            // Color(0xff196ec0),
            // Colors.blue,
            // Colors.lightBlue.withOpacity(0.6)
          ],
          // gradientStops: [0.3, 0.6, 0.8],
        ),
        WeatherForTheDay(city: 'Moscow', weather: dummyWeather)
      ],
    ));
  }
}
