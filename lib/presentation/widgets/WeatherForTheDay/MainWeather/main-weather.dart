import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:weather_app2/presentation/utils/mapWeatherConditionsToAsset.dart';
import 'package:supercharged/supercharged.dart';

class MainWeather extends StatefulWidget {
  final WeatherWithHourlyForecast weather;

  MainWeather({this.weather});

  @override
  _MainWeatherState createState() => _MainWeatherState();
}

class _MainWeatherState extends State<MainWeather>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine);
    _controller.play();
  }

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
        ScaleTransition(
          scale: _animation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  widget.weather.temperature.round().toString(),
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
                    mapWeatherConditionsToAsset(
                        widget.weather.conditions,
                        DateTime.now(),
                        widget.weather.sunrise,
                        widget.weather.sunset),
                    width: 120,
                    height: 120),
              ),
            ],
          ),
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
              widget.weather.windSpeed.toString() + ' km/h',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ],
    );
  }
}
