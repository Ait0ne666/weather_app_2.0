import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app2/domain/entities/City/city.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_bloc.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_event.dart';
import 'package:weather_app2/presentation/widgets/WeatherForTheDay/MainWeather/main-weather.dart';
import 'package:weather_app2/presentation/widgets/WeatherForTheDay/Sunrise/sunrise.dart';
import 'package:weather_app2/presentation/widgets/WeatherForTheDay/WeatherChart/weather_chart.dart';
import 'package:weather_app2/presentation/widgets/WeatherList/weather_list.dart';

class WeatherForTheDay extends StatelessWidget {
  final City city;
  

  WeatherForTheDay({this.city});

  String get currentDate {
    DateTime date = DateTime.now();
    DateFormat formatter = DateFormat('EEEE, dd MMMM   HH:mm');
    final String formattedDate = formatter.format(date);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()  {
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
                              city.name,
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
                          weather: city.currentWeather,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: WeatherList(
                            weatherData: city.dailyWeather,
                          ),
                        )
                      ],
                    ),
                  ),
                  WeatherChart(city.currentWeather.hourlyForecast)
                ],
              ),
            ),
        ),
      ),
    );
  }
}
