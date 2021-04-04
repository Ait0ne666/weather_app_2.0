import 'package:flutter/material.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:weather_app2/presentation/utils/mapWeatherConditionsToAsset.dart';



class GridWeatherItem extends StatelessWidget {
  final Weather weather;


  GridWeatherItem({this.weather});

  String get dayOfWeek {
    switch (weather.time.weekday) {
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


  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
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
                      mapWeatherConditionsToAsset(weather.conditions, weather.time,
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
                      fit:  BoxFit.contain,
                      child: Text(
                        weather.dayTemp.round().toString() +
                            '°/' +
                            weather.nightTemp.round().toString() +
                            '°',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}