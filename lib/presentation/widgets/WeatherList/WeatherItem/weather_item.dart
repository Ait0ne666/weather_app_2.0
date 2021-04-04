import 'dart:ui';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:weather_app2/presentation/navigation/NavigationRouter.dart';
import 'package:weather_app2/presentation/utils/mapWeatherConditionsToAsset.dart';

class WeatherItem extends StatelessWidget {
  final DateTime date;
  final Weather weather;

  WeatherItem({this.date, this.weather});

  String get dayOfWeek {
    switch (date.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "Mon";
    }
  }

  double getItemWidth(BuildContext context) {
    return (MediaQuery.of(context).size.width - 54) / 4;
  }

  Widget getItemPicture(WeatherConditions conditions) {
    switch (conditions) {
      case WeatherConditions.RAIN:
        return SvgPicture.asset(
          'assets/SVG/day_rain.svg',
          width: 22,
          height: 22,
          color: Colors.white,
        );
      case WeatherConditions.CLEAR:
        return SvgPicture.asset(
          'assets/SVG/day_clear.svg',
          width: 22,
          height: 22,
          color: Colors.white,
        );
      case WeatherConditions.CLOUDS:
        return SvgPicture.asset(
          'assets/SVG/cloudy.svg',
          width: 22,
          height: 22,
          color: Colors.white,
        );
      case WeatherConditions.SNOW:
        return SvgPicture.asset(
          'assets/SVG/day_snow.svg',
          width: 22,
          height: 22,
          color: Colors.white,
        );
      case WeatherConditions.SUNNY:
        return SvgPicture.asset(
          'assets/SVG/day_sleet.svg',
          width: 22,
          height: 22,
          color: Colors.white,
        );
      default:
        return SvgPicture.asset(
          'assets/SVG/day_rain.svg',
          width: 22,
          height: 22,
          color: Colors.white,
        );
    }
  }

  String getFormattedDate(date) {
    DateFormat format = DateFormat('dd.MM');
    return format.format(date);
  }


  void showDetail(BuildContext context) {
    NavigationRouter.router.navigateTo(context, '/dayWeather', transition: TransitionType.cupertino, routeSettings: RouteSettings(arguments: weather));
  }


  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('dd.MM HH:mm');

    return Center(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 40,
            sigmaY: 40,
          ),
          child: InkWell(
            onTap: () => showDetail(context),
            child: Container(
              
              width: getItemWidth(context),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(0.7),
                ),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.05),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dayOfWeek,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      child: Center(
                    child: Image.asset(
                      mapWeatherConditionsToAsset(weather.conditions, date,
                          weather.sunrise, weather.sunset),
                      width: 22,
                      height: 22,
                    ),
                  )),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 4),
                    child: FittedBox(
                      child: Text(
                        weather.dayTemp.round().toString() +
                            '°/' +
                            weather.nightTemp.round().toString() +
                            '°',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    getFormattedDate(date),
                    style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 12,
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
