import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:weather_app2/presentation/widgets/DayWeatherDetail/DayTemperature/day_temperature.dart';
import 'package:weather_app2/presentation/widgets/DayWeatherDetail/Details/details.dart';
import 'package:weather_app2/presentation/widgets/DayWeatherDetail/SunriseSunset/sunrise_sunset.dart';

class DayWeatherDetail extends StatefulWidget {
  final Weather dayWeather;

  DayWeatherDetail({this.dayWeather});

  @override
  _DayWeatherDetailState createState() => _DayWeatherDetailState();
}

class _DayWeatherDetailState extends State<DayWeatherDetail>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleReorder(int prevIndex, int newIndex) {
    print(prevIndex);
    print(newIndex);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: _controller, curve: Curves.easeIn),
      child: Container(
        // color: Colors.white.withOpacity(0.2),
        child: ReorderableListView(
          onReorder: handleReorder,
          proxyDecorator: (child, index, animation) => child,
          // draggingWidgetOpacity: 0.9,
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
          children: [
            DayTemperature(
              key: UniqueKey(),
              dayTemp: widget.dayWeather.dayTemp,
              eveTemp: widget.dayWeather.dayTemp,
              nightTemp: widget.dayWeather.nightTemp,
              mornTemp: widget.dayWeather.mornTemp,
            ),
            Details(widget.dayWeather, UniqueKey()),
          ],
        ),
      ),
    );
  }
}
