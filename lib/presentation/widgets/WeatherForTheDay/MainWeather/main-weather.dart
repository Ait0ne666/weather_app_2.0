import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';

class MainWeather extends StatelessWidget {
  final Weather weather;

  MainWeather({this.weather});

  String get currentDate {
    DateTime date = DateTime.now();
    DateFormat formatter = DateFormat('HH:mm');
    final String formattedDate = formatter.format(date);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                weather.temperature.toString(),
                style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                '°',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ]),
            Image.asset('assets/sunny.png'),
          ],
        ),
        // SizedBox(
        //   height: 25,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/wind.svg',
              width: 20,
              height: 20,
              color: Colors.white.withOpacity(0.6),
            ),
            SizedBox(width: 5),
            Text(
              weather.windSpeed.toString() + ' km/h',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ],
    );
  }
}
