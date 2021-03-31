import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:weather_app2/presentation/utils/mapWeatherConditionsToAsset.dart';

class MainWeather extends StatelessWidget {
  final WeatherWithHourlyForecast weather;

  MainWeather({this.weather});

  String get currentDate {
    DateTime date = DateTime.now();
    DateFormat formatter = DateFormat('HH:mm');
    final String formattedDate = formatter.format(date);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    print('444' + weather.sunrise.toString());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                weather.temperature.round().toString(),
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
            Center(
              child: Image.asset(
                  mapWeatherConditionsToAsset(weather.conditions,
                      DateTime.now(), weather.sunrise, weather.sunset),
                  width: 120,
                  height: 120),
            ),
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
