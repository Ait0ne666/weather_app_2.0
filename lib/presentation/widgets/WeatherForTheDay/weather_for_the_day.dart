import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app2/domain/entities/City/city.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_bloc.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_event.dart';
import 'package:weather_app2/presentation/widgets/DayWeatherDetail/SunriseSunset/sunrise_sunset.dart';
import 'package:weather_app2/presentation/widgets/WeatherForTheDay/MainWeather/main-weather.dart';
import 'package:weather_app2/presentation/widgets/WeatherForTheDay/Sunrise/sunrise.dart';
import 'package:weather_app2/presentation/widgets/WeatherForTheDay/WeatherChart/weather_chart.dart';
import 'package:weather_app2/presentation/widgets/WeatherList/weather_list.dart';

class WeatherForTheDay extends StatefulWidget {
  final City city;

  WeatherForTheDay({this.city});

  @override
  _WeatherForTheDayState createState() => _WeatherForTheDayState();
}

class _WeatherForTheDayState extends State<WeatherForTheDay> {
  String get currentDate {
    DateTime date = DateTime.now();
    DateFormat formatter = DateFormat('EEEE, dd MMMM   HH:mm');
    final String formattedDate = formatter.format(date);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<CitiesBloc>(context).add(UpdateCities());
        return Future.value(null);
      },
      backgroundColor: Colors.transparent,
      color: Color(0xffF27121),
      child: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.transparent,
          child: SingleChildScrollView(
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
                            widget.city.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 5),
                          Text(
                            currentDate,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100),
                          ),
                          Sunrise(
                            sunrise: widget.city.currentWeather.sunrise,
                            sunset: widget.city.currentWeather.sunset,
                          ),
                        ],
                      ),
                      MainWeather(
                        weather: widget.city.currentWeather,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: WeatherList(
                          weatherData: widget.city.dailyWeather,
                        ),
                      )
                    ],
                  ),
                ),
                WeatherChart(
                  widget.city.currentWeather.hourlyForecast,
                  widget.city.currentWeather.sunrise,
                  widget.city.currentWeather.sunset,
                ),
                SunriseSunset(widget.city.currentWeather),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChartInView extends InheritedWidget {
  final bool inView;

  const ChartInView({@required Widget child, this.inView})
      : super(child: child);

  static ChartInView of(BuildContext context) {
    final ChartInView result =
        context.dependOnInheritedWidgetOfExactType<ChartInView>();
    assert(result != null, 'No inView found in context');
    return result;
  }

  @override
  bool updateShouldNotify(ChartInView old) => inView != old.inView;
}
