import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/domain/entities/Weather/weather.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_bloc.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_state.dart';
import 'package:weather_app2/presentation/navigation/NavigationRouter.dart';
import 'package:weather_app2/presentation/screens/ScreenWrapper/screen-wrapper.dart';
import 'package:weather_app2/presentation/widgets/DayWeatherDetail/day_weather_detail.dart';
import 'package:weather_app2/presentation/widgets/common/FailureScreen/failure_screen.dart';

class DayDetail extends StatelessWidget {
  final Weather dayWeather;

  DayDetail(this.dayWeather);

  void navigateBack(BuildContext context) {
    NavigationRouter.router.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      children: [
        Positioned(
          child:
              BlocBuilder<CitiesBloc, CitiesState>(builder: (context, state) {
            if (state is CitiesLoaded || state is CitiesUpdating) {
              return DayWeatherDetail(
                dayWeather: dayWeather,
              );
            } else {
              return FailureScreen();
            }
          }),
        ),
        Positioned(
            top: 50,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              color: Colors.transparent,
              child: Row(children: [
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  iconSize: 35,
                  onPressed: () => navigateBack(context),
                ),
              ]),
            ))
      ],
    );
  }
}
