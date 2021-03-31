import 'package:flutter/material.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:weather_app2/presentation/widgets/WeatherList/Pagination/pagination.dart';
import 'package:weather_app2/presentation/widgets/WeatherList/WeatherItem/weather_item.dart';

class WeatherList extends StatefulWidget {
  final List<Weather> weatherData;

  WeatherList({this.weatherData});

  @override
  _WeatherListState createState() => _WeatherListState();
}

class _WeatherListState extends State<WeatherList> {
  int currentPage = 0;

  List<Widget> getWeatherList(weatherData) {
    List<Widget> result = [];

    weatherData.asMap().forEach((index, Weather weather) {
      result.add(WeatherItem(
          weather: weather, date: weather.sunrise.add(Duration(hours: 4))));
      if (index < weatherData.length - 1) {
        result.add(SizedBox(width: 8));
      }
    });
    return result;
  }

  void onPageChange(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          child: PageView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: getWeatherList(widget.weatherData.sublist(0, 4)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: getWeatherList(widget.weatherData.sublist(4, 7)),
                ),
              ),
            ],
            onPageChanged: onPageChange,
            scrollDirection: Axis.horizontal,
          ),
        ),
        Pagination(
          currenPage: currentPage,
          pageNumber: 2,
        )
      ],
    );
  }
}
