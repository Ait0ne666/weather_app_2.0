import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_bloc.dart';
import 'package:weather_app2/presentation/bloc/CitiesBloc/cities_state.dart';
import 'package:weather_app2/presentation/navigation/NavigationRouter.dart';
import 'package:weather_app2/presentation/widgets/WeatherForTheDay/weather_for_the_day.dart';
import 'package:weather_app2/presentation/widgets/common/FailureScreen/failure_screen.dart';
import 'package:weather_app2/presentation/widgets/common/Sky/sky.dart';

class MainScreen extends StatelessWidget {
  void openCitiesMenu(BuildContext context) {
    print('press');
    NavigationRouter.router
        .navigateTo(context, '/cities', transition: TransitionType.fadeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Sky(
        gradientColors: [
          Color(0xff631961),
          Color(0xffE94057),
          Color(0xffF27121)
        ],
      ),
      BlocBuilder<CitiesBloc, CitiesState>(builder: (context, state) {
        if (state is CitiesLoaded || state is CitiesUpdating) {
          return WeatherForTheDay(city: state.cities[state.currentCity]);
        } else {
          return FailureScreen();
        }
      }),
      Positioned(
          top: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(children: [
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                iconSize: 35,
                onPressed: () => openCitiesMenu(context),
              ),
            ]),
          ))
    ]));
  }
}
