import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:weather_app2/presentation/bloc/SettingsBloc/setting_bloc.dart';
import 'package:weather_app2/presentation/bloc/SettingsBloc/settings_event.dart';
import 'package:weather_app2/presentation/widgets/DayWeatherDetail/DayTemperature/day_temperature.dart';
import 'package:weather_app2/presentation/widgets/DayWeatherDetail/Details/details.dart';
import 'package:weather_app2/presentation/widgets/DayWeatherDetail/Moon/moon.dart';

class DayWeatherDetail extends StatefulWidget {
  final Weather dayWeather;
  final List<String> widgets;

  DayWeatherDetail({this.dayWeather, this.widgets});

  @override
  _DayWeatherDetailState createState() => _DayWeatherDetailState();
}

class _DayWeatherDetailState extends State<DayWeatherDetail>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
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
    var newCards = [...widget.widgets];
    if (prevIndex > newIndex) {
      final String item = newCards.removeAt(prevIndex);
      newCards.insert(newIndex, item);
    } else if (prevIndex < newIndex) {
      final item = newCards.removeAt(prevIndex);
      newCards.insert(newIndex - 1, item);
    }
    BlocProvider.of<SettingsBloc>(context).add(SetDetailCards(newCards));
  }

  List<Widget> buildList() {
    List<Widget> items = [];
    for (int i = 0; i < widget.widgets.length; i++) {
      if (widget.widgets[i] == 'temperature') {
        items.add(DayTemperature(
          key: UniqueKey(),
          dayTemp: widget.dayWeather.dayTemp,
          eveTemp: widget.dayWeather.dayTemp,
          nightTemp: widget.dayWeather.nightTemp,
          mornTemp: widget.dayWeather.mornTemp,
        ));
      } else if (widget.widgets[i] == 'details') {
        items.add(Details(widget.dayWeather, UniqueKey()));
      } else if (widget.widgets[i] == 'moon' &&
          widget.dayWeather.moonPhase != null) {
        items.add(Moon(widget.dayWeather, UniqueKey()));
      }
    }
    return items;
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
          children: buildList(),
        ),
      ),
    );
  }
}
