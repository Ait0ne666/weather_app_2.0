import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:weather_app2/dummyData/weatherData.dart';
import 'package:weather_app2/presentation/widgets/WeatherForTheDay/MainWeather/main-weather.dart';
import 'package:weather_app2/presentation/widgets/WeatherForTheDay/Sunrise/sunrise.dart';
import 'package:weather_app2/presentation/widgets/WeatherForTheDay/WeatherChart/weather_chart.dart';
import 'package:weather_app2/presentation/widgets/WeatherList/weather_list.dart';

class WeatherForTheDay extends StatelessWidget {
  final String city;
  final WeatherWithHourlyForecast weather;

  WeatherForTheDay({this.city, this.weather});

  String get currentDate {
    DateTime date = DateTime.now();
    DateFormat formatter = DateFormat('EEEE, dd MMMM   HH:mm');
    final String formattedDate = formatter.format(date);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            // padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      city,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 5),
                    Text(
                      currentDate,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w100),
                    ),
                    Sunrise(),
                  ],
                ),
                MainWeather(
                  weather: weather,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: WeatherList(
                    weatherData: weatherData,
                  ),
                )
              ],
            ),
          ),
          WeatherChart(weather.hourlyForecast)
        ],
      ),
    );
  }
}
